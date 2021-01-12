<p align="center">
  <img src="https://raw.githubusercontent.com/meilisearch/integration-guides/master/assets/logos/logo.svg" alt="Instant-MeiliSearch" width="200" height="200" />
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
  <a href="https://github.com/meilisearch/meilisearch-kubernetes/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-informational" alt="License"></a>
</p>

<p align="center">The MeiliSearch tool for Kubernetes ⚓️</p>

**MeiliSearch** is an open-source search engine. [Discover what MeiliSearch is!](https://github.com/meilisearch/MeiliSearch)

# MeiliSearch tools for Kubernetes deployment

Kubernetes (K8s), is an open-source system for automating deployment, scaling, and management of containerized applications. You can run a MeiliSearch instance inside your Kubernetes cluster, either if you want to expose it to the outside world or just let some other applications use it inside your cluster and take advantage of the instant and powerful search engine.

# Getting started

First of all, you will need a Kubernetes cluster up and running. If you are not familiar with how Kuberentes works or need some help with this step, please check the [Kubernetes documentation](https://kubernetes.io/docs/home/).

## Install kubectl

`kubectl` is the most commonly used CLI to manage a Kubernetes cluster. The installation instructions are [available here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## Deploy MeiliSearch using manifests

### Install and run MeiliSearch

```bash
kubectl apply -f manifests/meilisearch.yaml
```

### Uninstall MeiliSearch

```bash
kubectl delete -f manifests/meilisearch.yaml
```

## Deploy MeiliSearch using Helm

Helm works as a package manager to run pre-configured Kubernetes resources. Using our [Helm chart](https://github.com/meilisearch/meilisearch-kubernetes/tree/master/charts/meilisearch) you will be able to deploy a MeiliSearch instance in you Kubernetes cluster, with several customizable configurations.

### Install helm

Helm CLI is a Command Line Interface which will automate chart management and installation on your Kubernetes cluster. To install Helm, follow the [Helm installation instructions](https://helm.sh/docs/intro/install/).

The [Parameters](https://github.com/meilisearch/meilisearch-kubernetes/tree/master/charts/meilisearch#parameters) section lists the parameters that can be configured during installation.

### Install MeiliSearch chart

Clone this repository and install the chart

```bash
git clone https://github.com/meilisearch/meilisearch-kubernetes.git
cd meilisearch-kubernetes
# Replace <your-instance-name> with the name you would like to give to your service
helm install <your-service-name> charts/meilisearch
```

### Uninstalling the Chart

To uninstall/delete the MeiliSearch` deployment:

```bash
# Replace <your-instance-name> with the name of your deployed service
helm uninstall <your-service-name>
```

<hr>

**MeiliSearch** provides and maintains many **SDKs and Integration tools** like this one. We want to provide everyone with an **amazing search experience for any kind of project**. If you want to contribute, make suggestions, or just know what's going on right now, visit us in the [integration-guides](https://github.com/meilisearch/integration-guides) repository.
