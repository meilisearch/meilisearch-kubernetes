# Meilisearch

A chart to deploy [Meilisearch](https://github.com/meilisearch/MeiliSearch) search engine

## Installation

To install the chart with the release name `my-release`:

```bash
helm install --name my-release <meilisearch-repo>/meilisearch
```

This command deploys MeiliSearch on the Kubernetes cluster using the default configuration. The [Configuration]() section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm delete my-release
```


## Parameters

| Parameter                        | Description                                                    | Default                           |
|----------------------------------|----------------------------------------------------------------|-----------------------------------|
| `nameOverride`                   | String to partially override meilisearch.fullname              | `nil`
|
| `fullnameOverride`               | String to fully override meilisearch.fullname                  | `nil`
|
| `replicaCount`                   | Number of MeiliSearch pods to run                              | `1`
|
| `environment.MEILI_ENV`          | Sets the environment. Either **production** or **development** | `development`
|
| `environment.MEILI_NO_ANALYTICS` | Deactivates analytics                                          | `true`
|
| `image.repository`               | MeiliSearch image name                                         | `getmeili/meilisearch`
|
| `image.tag`                      | MeiliSearch image tag                                          | `{TAG_NAME}`
|
| `image.pullPolicy`               | MeiliSearch image pull policy                                  | `IfNotPresent`
|
| `ingress.enabled`                | Enable ingress controller resource                             | `false`
|
| `ingress.annotations`            | Ingress annotations                                            | `{}`
|
| `ingress.path`                   | Path within the host                                           | `/`
|
| `ingress.hosts`                  | List of hostnames                                              | `[meilisearch-example.local]`
|
| `ingress.tls`                    | TLS specification                                              | `[]`
|
| `service.port`                   | Service HTTP port                                              | `ClusterIP`
|
| `service.type`                   | Kubernetes Service type                                        | `7700`
|
| `persistence.enabled`            | Enable persistence using PVC                                   | `false`
|
| `persistence.accessMode`         | PVC Access Mode                                                | `ReadWriteOnce`
|
| `persistence.storageClass`       | PVC Storage Class                                              | `-` (No storage class)
|
| `persistence.size`               | PVC Storage Request                                            | `10Gi`
|
| `resources`                      | Resources allocation (Requests and Limits)                     | `{}`
|
| `tolerations`                    | Tolerations for pod assignment                                 | `[]`
|
| `nodeSelector`                   | Node labels for pod assignment                                 | `{}`
|
| `affinity`                       | Affinity for pod assignment                                    | `{}`

### Environment

The `environment` block allows to specify all the environment variables declared on [MeiliSearch Configuration](https://docs.meilisearch.com/guides/advanced_guides/configuration.html#passing-arguments-via-the-command-line)

For production deployment, the `environment.MEILI_MASTER_KEY` is required
