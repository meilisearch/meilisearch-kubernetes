<p align="center">
  <img src="https://raw.githubusercontent.com/meilisearch/integration-guides/master/assets/logos/logo.svg" alt="Instant-MeiliSearch" width="200" height="200" />
</p>

<h1 align="center">MeiliSearch Kubernetes</h1>

<h4 align="center">
  <a href="https://github.com/meilisearch/MeiliSearch">MeiliSearch</a> |
  <a href="https://www.meilisearch.com">Website</a> |
  <a href="https://blog.meilisearch.com">Blog</a> |
  <a href="https://twitter.com/meilisearch">Twitter</a> |
  <a href="https://docs.meilisearch.com">Documentation</a> |
  <a href="https://docs.meilisearch.com/faq">FAQ</a>
</h4>

<p align="center">
  <a href="https://github.com/meilisearch/meilisearch-kubernetes/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-informational" alt="License"></a>
  <a href="https://slack.meilisearch.com"><img src="https://img.shields.io/badge/slack-MeiliSearch-blue.svg?logo=slack" alt="Slack"></a>
</p>

<p align="center">⚡ Lightning Fast, Ultra Relevant, and Typo-Tolerant Search Engine MeiliSearch tools for Kubernetes deployment</p>

# MeiliSearch tools for Kubernetes deployment

Kubernetes (K8s), is an open-source system for automating deployment, scaling, and management of containerized applications. You can run a MeiliSearch instance inside your Kubernetes cluster, either if you want to expose it to the outside world or just let some other applications use it inside your cluster and take advantage of the instant and powerful search engine.

This repository's goal is to collect tools and examples of Kubernetes configurations and packages (Manifests, Helm charts, etc...) in order to make it simple to integrate a MeiliSearch instance in a Kubernetes cluster.

## HELM

Helm works as a package manager to run pre-configured Kubernetes resources. Using our [Helm chart](https://github.com/meilisearch/meilisearch-kubernetes/tree/master/charts/meilisearch) you will be able to deploy a MeiliSearch instance in you Kubernetes cluster, with several customizable configurations. If you want some guides on how to use it, check our [Helm chart Getting started](https://github.com/meilisearch/meilisearch-kubernetes/blob/master/charts/meilisearch/README.md#getting-started). 

<hr>

**MeiliSearch** provides and maintains many **SDKs and Integration tools** like this one. We want to provide everyone with an **amazing search experience for any kind of project**. If you want to contribute, make suggestions, or just know what's going on right now, visit us in the [integration-guides](https://github.com/meilisearch/integration-guides) repository.

