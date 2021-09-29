<p align="center">
  <img src="https://raw.githubusercontent.com/meilisearch/integration-guides/main/assets/logos/meilisearch_k8s.svg" alt="Instant-MeiliSearch" width="200" height="200" />
</p>

<h1 align="center">MeiliSearch Kubernetes</h1>

<h4 align="center">
  <a href="https://github.com/meilisearch/MeiliSearch">MeiliSearch</a> |
  <a href="https://docs.meilisearch.com">Documentation</a> |
  <a href="https://slack.meilisearch.com">Slack</a> |
  <a href="https://www.meilisearch.com">Website</a> |
  <a href="https://blog.meilisearch.com">Blog</a> |
  <a href="https://docs.meilisearch.com/faq">FAQ</a>
</h4>

<p align="center">
  <a href="https://github.com/meilisearch/meilisearch-kubernetes/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-informational" alt="License"></a>
</p>

<p align="center">The MeiliSearch tool for Kubernetes ⚓️</p>

**MeiliSearch** is an open-source search engine. [Discover what MeiliSearch is!](https://github.com/meilisearch/MeiliSearch)

## Table of Contents <!-- omit in toc -->

- [📖 Documentation](#-documentation)
- [🚀 Getting Started](#-getting-started)
- [🤖 Compatibility with MeiliSearch](#-compatibility-with-meilisearch)
- [⚙️ Development Workflow and Contributing](#️-development-workflow-and-contributing)

## 📖 Documentation

See our [Documentation](https://docs.meilisearch.com/learn/tutorials/getting_started.html) or our [API References](https://docs.meilisearch.com/reference/api/).

## 🚀 Getting Started


Kubernetes (K8s), is an open-source system for automating deployment, scaling, and management of containerized applications. You can run a MeiliSearch instance inside your Kubernetes cluster, either if you want to expose it to the outside world or just let some other applications use it inside your cluster and take advantage of the instant and powerful search engine.

First of all, you will need a Kubernetes cluster up and running. If you are not familiar with how Kuberentes works or need some help with this step, please check the [Kubernetes documentation](https://kubernetes.io/docs/home/).

### Install kubectl <!-- omit in toc -->

`kubectl` is the most commonly used CLI to manage a Kubernetes cluster. The installation instructions are [available here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

### Deploy MeiliSearch using manifests <!-- omit in toc -->

#### Install and run MeiliSearch <!-- omit in toc -->

```bash
kubectl apply -f manifests/meilisearch.yaml
```

#### Uninstall MeiliSearch <!-- omit in toc -->

```bash
kubectl delete -f manifests/meilisearch.yaml
```

### Deploy MeiliSearch using Helm <!-- omit in toc -->

Helm works as a package manager to run pre-configured Kubernetes resources. Using our [Helm chart](https://github.com/meilisearch/meilisearch-kubernetes/tree/main/charts/meilisearch) you will be able to deploy a MeiliSearch instance in you Kubernetes cluster, with several customizable configurations.

#### Install helm <!-- omit in toc -->

Helm CLI is a Command Line Interface which will automate chart management and installation on your Kubernetes cluster. To install Helm, follow the [Helm installation instructions](https://helm.sh/docs/intro/install/).

The [Parameters](https://github.com/meilisearch/meilisearch-kubernetes/tree/main/charts/meilisearch#parameters) section lists the parameters that can be configured during installation.

#### Install MeiliSearch chart <!-- omit in toc -->

First, add the meilisearch chart repository
```bash
helm repo add meilisearch https://meilisearch.github.io/meilisearch-kubernetes
```

Now install/upgrade the chart
```bash
# Replace <your-instance-name> with the name you would like to give to your service
helm upgrade -i <your-service-name> meilisearch/meilisearch
```

#### Uninstalling the Chart <!-- omit in toc -->

To uninstall/delete the MeiliSearch` deployment:

```bash
# Replace <your-instance-name> with the name of your deployed service
helm uninstall <your-service-name>
```

## 🤖 Compatibility with MeiliSearch

This chart only guarantees the compatibility with the [version v0.23.0 of MeiliSearch](https://github.com/meilisearch/MeiliSearch/releases/tag/v0.23.0).

## ⚙️ Development Workflow and Contributing

Any new contribution is more than welcome in this project!

If you want to know more about the development workflow or want to contribute, please visit our [contributing guidelines](/CONTRIBUTING.md) for detailed instructions!

<hr>

**MeiliSearch** provides and maintains many **SDKs and Integration tools** like this one. We want to provide everyone with an **amazing search experience for any kind of project**. If you want to contribute, make suggestions, or just know what's going on right now, visit us in the [integration-guides](https://github.com/meilisearch/integration-guides) repository.
