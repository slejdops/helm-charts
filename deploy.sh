#!/bin/bash
openssl aes-256-cbc -K $encrypted_2ba986d7921c_key -iv $encrypted_2ba986d7921c_iv -in helm-chart-deploy-key.enc -out helm-chart-deploy-key -d

chmod 0400 helm-chart-deploy-key

helm init --client-only
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm dependency update malariagen

GIT_SSH_COMMAND="ssh -i ${PWD}/helm-chart-deploy-key" chartpress --commit-range ${TRAVIS_COMMIT_RANGE} --publish-chart

