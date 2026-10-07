#!/usr/bin/env bash
# Bumps Meilisearch to the given version: Chart.yaml (appVersion + chart version),
# values.yaml, README.md compatibility section and the generated manifest.
#
# The chart version is bumped relative to the current Chart.yaml:
# - new Meilisearch major/minor (e.g., v1.55.2 -> v1.56.0) => chart minor bump (e.g., 0.40.1 -> 0.41.0)
# - new Meilisearch patch       (e.g., v1.56.0 -> v1.56.1) => chart patch bump (e.g., 0.41.0 -> 0.41.1)
#
# Usage: bump-meilisearch-version.sh <version>
# When running in GitHub Actions, writes needs_update, bump_type and chart_version to $GITHUB_OUTPUT.

set -euo pipefail

CHART_FILE="charts/meilisearch/Chart.yaml"
VALUES_FILE="charts/meilisearch/values.yaml"
GITHUB_OUTPUT="${GITHUB_OUTPUT:-/dev/null}"

# Sanitize: remove newlines, carriage returns, and % characters to prevent injection
NEW_VERSION=$(printf '%s' "${1:-}" | tr -d '\n\r%')

if [ -z "$NEW_VERSION" ]; then
  echo "::error::No version provided"
  exit 1
fi

# Validate against SemVer pattern (optional v prefix, MAJOR.MINOR.PATCH, optional pre-release/build)
SEMVER_REGEX='^v?[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.]+)?(\+[a-zA-Z0-9.]+)?$'
if ! [[ "$NEW_VERSION" =~ $SEMVER_REGEX ]]; then
  echo "::error::Invalid version format '$NEW_VERSION'. Expected SemVer (e.g., v1.2.3 or 1.2.3-beta.1)"
  exit 1
fi

CURRENT_APP_VERSION=$(grep -oP 'appVersion: "\K[^"]+' "$CHART_FILE")
CURRENT_CHART_VERSION=$(grep -oP '^version: \K.*' "$CHART_FILE")
echo "📌 Current version: $CURRENT_APP_VERSION (chart $CURRENT_CHART_VERSION)"
echo "📦 New Meilisearch version: $NEW_VERSION"

if [ "$NEW_VERSION" = "$CURRENT_APP_VERSION" ]; then
  echo "::notice::Version $NEW_VERSION is already the current version"
  echo "needs_update=false" >> "$GITHUB_OUTPUT"
  exit 0
fi

# Strip "v" prefix and pre-release/build suffixes (e.g., v1.56.0-rc.1 -> 1.56.0)
core_version() {
  printf '%s' "$1" | sed -E 's/^v//; s/[-+].*$//'
}
CURRENT_APP_CORE=$(core_version "$CURRENT_APP_VERSION")
NEW_APP_CORE=$(core_version "$NEW_VERSION")

# Refuse to downgrade Meilisearch
if [ "$(printf '%s\n%s\n' "$CURRENT_APP_CORE" "$NEW_APP_CORE" | sort -V | tail -n1)" != "$NEW_APP_CORE" ]; then
  echo "::error::Version $NEW_VERSION is older than the current version $CURRENT_APP_VERSION"
  exit 1
fi

# Validate CURRENT_CHART_VERSION is not empty
if [ -z "$CURRENT_CHART_VERSION" ]; then
  echo "::error::Failed to parse 'version' from Chart.yaml (empty or missing)"
  exit 1
fi

MAJOR=$(echo "$CURRENT_CHART_VERSION" | cut -d. -f1)
MINOR=$(echo "$CURRENT_CHART_VERSION" | cut -d. -f2)
PATCH=$(echo "$CURRENT_CHART_VERSION" | cut -d. -f3)

# Validate MAJOR, MINOR and PATCH are numeric
for PART in "$MAJOR" "$MINOR" "$PATCH"; do
  if ! [[ "$PART" =~ ^[0-9]+$ ]]; then
    echo "::error::Invalid version component '$PART' (expected numeric) in Chart.yaml version '$CURRENT_CHART_VERSION'"
    exit 1
  fi
done

if [ "$(echo "$CURRENT_APP_CORE" | cut -d. -f1,2)" = "$(echo "$NEW_APP_CORE" | cut -d. -f1,2)" ]; then
  BUMP_TYPE="patch"
  NEW_CHART_VERSION="${MAJOR}.${MINOR}.$((PATCH + 1))"
else
  BUMP_TYPE="minor"
  NEW_CHART_VERSION="${MAJOR}.$((MINOR + 1)).0"
fi

# Update Chart.yaml (escape sed-special characters: /, &, \)
ESCAPED_VERSION=$(printf '%s\n' "$NEW_VERSION" | sed 's/[\/&]/\\&/g')
sed -i "s/^appVersion: .*/appVersion: \"$ESCAPED_VERSION\"/" "$CHART_FILE"
sed -i "s/^version: .*/version: $NEW_CHART_VERSION/" "$CHART_FILE"
echo "📊 Chart version ($BUMP_TYPE bump): $CURRENT_CHART_VERSION -> $NEW_CHART_VERSION"

# Update README.md compatibility section
sed -i "s|version v[0-9.]*[0-9] of Meilisearch|version $ESCAPED_VERSION of Meilisearch|g" README.md
sed -i "s|meilisearch/releases/tag/v[0-9.]*[0-9]|meilisearch/releases/tag/$ESCAPED_VERSION|g" README.md

# Update values.yaml
NEW_VERSION="$NEW_VERSION" yq eval '.image.tag = strenv(NEW_VERSION)' -i "$VALUES_FILE"

# Regenerate manifests
helm template meilisearch charts/meilisearch | grep -v 'helm.sh/chart:\|app.kubernetes.io/managed-by:' > manifests/meilisearch.yaml

{
  echo "needs_update=true"
  echo "new_version=$NEW_VERSION"
  echo "bump_type=$BUMP_TYPE"
  echo "chart_version=$NEW_CHART_VERSION"
} >> "$GITHUB_OUTPUT"
