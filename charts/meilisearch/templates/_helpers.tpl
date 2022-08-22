{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "meilisearch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "meilisearch.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "meilisearch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "meilisearch.labels" -}}
helm.sh/chart: {{ include "meilisearch.chart" . }}
{{ include "meilisearch.selectorLabels" . }}
{{- if or .Chart.AppVersion .Values.image.tag }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: search-engine
app.kubernetes.io/part-of: {{ template "meilisearch.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
{{- end -}}


{{- define "meilisearch.selectorLabels" -}}
app.kubernetes.io/name: {{ include "meilisearch.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Checks for environment being set to "production" without a master key being set explicitly
*/}}
{{- define "isProductionWithoutMasterKey" -}}
{{- if and (eq .Values.environment.MEILI_ENV "production") (not .Values.environment.MEILI_MASTER_KEY) (not .Values.auth.existingMasterKeySecret) -}}
{{- "true" -}}
{{- else -}}
{{- "false" -}}
{{- end -}}
{{- end -}}

{{- define "secretMasterKeyName" -}}
    {{- if .Values.auth.existingMasterKeySecret -}}
        {{- printf "%s" (tpl .Values.auth.existingMasterKeySecret $) -}}
    {{- else -}}
        {{- printf "%s-master-key" (include "meilisearch.fullname" .) -}}
    {{- end -}}
{{- end -}}
