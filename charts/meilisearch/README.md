# Meilisearch

Helm works as a package manager to run pre-configured Kubernetes resources.

MeiliSearch provides a customizable Helm chart, ready to deploy a [Meilisearch](https://github.com/meilisearch/MeiliSearch) instance on your Kubernetes cluster.

# Getting started

First of all, you will need a Kubernetes cluster up and running. If you are not familiar with how Kuberentes works or need some help with this step, please check the [Kubernetes documentation](https://kubernetes.io/docs/home/).

## Install kubectl

`kubectl` is the most commonly used CLI to handle a Kubernetes cluster. The installation instructions are [available here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## Install helm

Helm CLI is a Command Line Interface which will automate chart management and installation on your Kubernetes cluster. To install Helm, follow the [Helm installation instructions](https://helm.sh/docs/intro/install/)

### Install MeiliSearch chart

Clone this repository and install the chart

```bash
git clone https://github.com/meilisearch/meilisearch-kubernetes.git
cd meilisearch-kubernetes
# Replace <your-instance-name> with the name you would like to give to your service
helm install <your-service-name> charts/meilisearch
```

This command deploys MeiliSearch on your Kubernetes cluster using the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the MeiliSearch` deployment:

```bash
# Replace <your-instance-name> with the name of your deployed service
helm uninstall <your-service-name>
```

## Parameters

| Parameter                        | Description                                                    | Default                           |
|----------------------------------|----------------------------------------------------------------|-----------------------------------|
| `nameOverride`                   | String to partially override meilisearch.fullname              | `nil`
| | |
| `fullnameOverride`               | String to fully override meilisearch.fullname                  | `nil`
| | |
| `replicaCount`                   | Number of MeiliSearch pods to run                              | `1`
| | |
| `environment.MEILI_ENV`          | Sets the environment. Either **production** or **development** | `development`
| | |
| `environment.MEILI_NO_ANALYTICS` | Deactivates analytics                                          | `true`
| | |
| `image.repository`               | MeiliSearch image name                                         | `getmeili/meilisearch`
| | |
| `image.tag`                      | MeiliSearch image tag                                          | `{TAG_NAME}`
| | |
| `image.pullPolicy`               | MeiliSearch image pull policy                                  | `IfNotPresent`
| | |
| `ingress.enabled`                | Enable ingress controller resource                             | `false`
| | |
| `ingress.annotations`            | Ingress annotations                                            | `{}`
| | |
| `ingress.path`                   | Path within the host                                           | `/`
| | |
| `ingress.hosts`                  | List of hostnames                                              | `[meilisearch-example.local]`
| | |
| `ingress.tls`                    | TLS specification                                              | `[]`
| | |
| `service.port`                   | Service HTTP port                                              | `ClusterIP`
| | |
| `service.type`                   | Kubernetes Service type                                        | `7700`
| | |
| `persistence.enabled`            | Enable persistence using PVC                                   | `false`
| | |
| `persistence.accessMode`         | PVC Access Mode                                                | `ReadWriteOnce`
| | |
| `persistence.storageClass`       | PVC Storage Class                                              | `-` (No storage class)
| | |
| `persistence.size`               | PVC Storage Request                                            | `10Gi`
| | |
| `resources`                      | Resources allocation (Requests and Limits)                     | `{}`
| | |
| `tolerations`                    | Tolerations for pod assignment                                 | `[]`
| | |
| `nodeSelector`                   | Node labels for pod assignment                                 | `{}`
| | |
| `affinity`                       | Affinity for pod assignment                                    | `{}`
| | |


### Environment

The `environment` block allows to specify all the environment variables declared on [MeiliSearch Configuration](https://docs.meilisearch.com/guides/advanced_guides/configuration.html#passing-arguments-via-the-command-line)

For production deployment, the `environment.MEILI_MASTER_KEY` is required. If `MEILI_ENV` is set to "production" without setting `environment.MEILI_MASTER_KEY`, then this chart will automatically create a secure `environment.MEILI_MASTER_KEY` as a secret. To get the value of this secret, you can read it with this command: `kubectl get secret meilisearch-master-key --template={{.data.MEILI_MASTER_KEY}} | base64 --decode`.