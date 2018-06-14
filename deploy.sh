#!/bin/bash

openssl aes-256-cbc -K $encrypted_499b71e625dc_key -iv $encrypted_499b71e625dc_iv -in github_deploy_key.enc -out github_deploy_key -d
chmod 0400 github_deploy_key

helm init --client-only
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm dependency update malariagen

GIT_SSH_COMMAND="ssh -i ${PWD}/github_deploy_key" chartpress --commit-range ${TRAVIS_COMMIT_RANGE} --publish-chart

