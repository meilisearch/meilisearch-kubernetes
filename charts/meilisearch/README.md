# Meilisearch

Helm works as a package manager to run pre-configured Kubernetes resources.

Meilisearch provides a customizable Helm chart, ready to deploy a [Meilisearch](https://github.com/meilisearch/meilisearch) instance on your Kubernetes cluster.

# Getting started

First of all, you will need a Kubernetes cluster up and running. If you are not familiar with how Kuberentes works or need some help with this step, please check the [Kubernetes documentation](https://kubernetes.io/docs/home/).

## Install kubectl

`kubectl` is the most commonly used CLI to handle a Kubernetes cluster. The installation instructions are [available here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## Install helm

Helm CLI is a Command Line Interface which will automate chart management and installation on your Kubernetes cluster. To install Helm, follow the [Helm installation instructions](https://helm.sh/docs/intro/install/)

### Install Meilisearch chart

Clone this repository and install the chart

```bash
git clone https://github.com/meilisearch/meilisearch-kubernetes.git
cd meilisearch-kubernetes
# Replace <your-instance-name> with the name you would like to give to your service
helm install <your-service-name> charts/meilisearch
```

This command deploys Meilisearch on your Kubernetes cluster using the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `Meilisearch` deployment:

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
| `replicaCount`                   | Number of Meilisearch pods to run                              | `1`
| | |
| `environment.MEILI_ENV`          | Sets the environment. Either **production** or **development** | `development`
| | |
| `environment.MEILI_NO_ANALYTICS` | Deactivates analytics                                          | `true`
| | |
| `auth.existingMasterKeySecret`   | Uses an existing secret that has the MEILI_MASTER_KEY set       | `nil`
| | |
| `envFrom`                        | Additional environment variables from ConfigMap or secrets      | `[]`
| | |
| `image.repository`               | Meilisearch image name                                         | `getmeili/meilisearch`
| | |
| `image.tag`                      | Meilisearch image tag                                          | `{TAG_NAME}`
| | |
| `image.pullPolicy`               | Meilisearch image pull policy                                  | `IfNotPresent`
| | |
| `image.pullSecret`               | Secret to authenticate against the docker registry             | '' |
|                                  |                                                                |
| `serviceAccount.create`          | Should this chart create a service account                     | `true`
|                                  |                                                                |
| `serviceAccount.annotations`     | Additional annotations for created service account             | `{}`
|                                  |                                                                |
| `serviceAccount.name`            | Custom service account name, if not created by this chart      | ''
|                                  |                                                                |
| `ingress.enabled`                | Enable ingress controller resource                             | `false`
| | |
| `ingress.annotations`            | Ingress annotations                                            | `{}`
| | |
| `ingress.className`              | Ingress ingressClassName                                       | `nginx`
| | |
| `ingress.path`                   | Path within the host                                           | `/`
| | |
| `ingress.hosts`                  | List of hostnames                                              | `[meilisearch-example.local]`
| | |
| `ingress.tls`                    | TLS specification                                              | `[]`
| | |
| `service.port`                   | Service HTTP port                                              | `7700`
| | |
| `service.type`                   | Kubernetes Service type                                        | `ClusterIP`
| | |
| `service.externalTrafficPolicy`  | Service external traffic policy                                | `-` (No external traffic policy)
| | |
| `service.loadBalancerIP`         | Service load balancer IP                                       | `-` (No load balancer IP)
| | |
| `service.annotations`            | Additional annotations for service                             | `{}`
| | |
| `persistence.enabled`            | Enable persistence using PVC                                   | `false`
| | |
| `persistence.existingClaim`      | Existing PVC                                                   | `false`
| | |
| `persistence.accessMode`         | PVC Access Mode                                                | `ReadWriteOnce`
| | |
| `persistence.storageClass`       | PVC Storage Class                                              | `-` (No storage class)
| | |
| `persistence.size`               | PVC Storage Request                                            | `10Gi`
| | |
| `persistence.annotations`        | Additional annotations for PVC                                 | `{}`
| | |
| `resources`                      | Resources allocation (Requests and Limits)                     | `{}`
| | |
| `command`                        | Pod command                                                    | `[]`
| | |
| `volumes`                        | Additional volumes for pod                                     | `[]`
| | |
| `volumeMounts`                   | Additional volumes to mount on pod                             | `[]`
| | |
| `containers`                     | Additional containers for pod                                  | `[]`
| | |
| `tolerations`                    | Tolerations for pod assignment                                 | `[]`
| | |
| `nodeSelector`                   | Node labels for pod assignment                                 | `{}`
| | |
| `affinity`                       | Affinity for pod assignment                                    | `{}`
| | |


### Environment

The `environment` block allows to specify all the environment variables declared on [Meilisearch Configuration](https://docs.meilisearch.com/guides/advanced_guides/configuration.html#passing-arguments-via-the-command-line)

For production deployment, the `environment.MEILI_MASTER_KEY` is required. If `MEILI_ENV` is set to "production" without setting `environment.MEILI_MASTER_KEY`, then this chart will automatically create a secure `environment.MEILI_MASTER_KEY` as a secret. To get the value of this secret, you can read it with this command: `kubectl get secret meilisearch-master-key --template={{.data.MEILI_MASTER_KEY}} | base64 --decode`. You can also use `auth.existingMasterKeySecret` to use an existing secret that has the key `MEILI_MASTER_KEY`
