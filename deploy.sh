#!/bin/bash


helm init --client-only
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm dependency update malariagen

GIT_SSH_COMMAND="ssh -i ${PWD}/helm-chart-deploy-key" chartpress --commit-range ${TRAVIS_COMMIT_RANGE} --publish-chart

