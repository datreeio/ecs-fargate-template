#!/bin/bash
set -ex
ECS_TIMEOUT=600

# If pull request - quit
if [[ "${TRAVIS_PULL_REQUEST}" == "true" ]]; then
  exit
else
  echo "TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"
fi

# Set env vars
SERVICE_NAME=`echo ${TRAVIS_REPO_SLUG} |awk '{split($0, a, "/"); print a[2]}'`
DOCKER_REGISTRY=<REPLACE>.dkr.ecr.us-east-1.amazonaws.com
DEPLOY=false

# Determine git branch
if [ "${TRAVIS_PULL_REQUEST}" == "false" ] && [ "${TRAVIS_BRANCH}" == "master" ]; then
  DEPLOY=true
  CLUSTER_NAME=production
  DOCKER_TAG=latest
elif [ "${TRAVIS_PULL_REQUEST}" == "false" ] && [ "${TRAVIS_BRANCH}" == "staging" ]; then
  DEPLOY=true
  CLUSTER_NAME=staging
  DOCKER_TAG=staging
fi

# Deploying only if on master/staging
if [ "${DEPLOY}" = true ]; then
  echo "Deploying service:${SERVICE_NAME} on to cluster:${CLUSTER_NAME} with image:${DOCKER_REGISTRY}/${SERVICE_NAME}:${DOCKER_TAG}"
  ./scripts/ecs-deploy.sh --timeout ${ECS_TIMEOUT} --max-definitions 5 --cluster "${CLUSTER_NAME}" --service-name "${SERVICE_NAME}" --image "${DOCKER_REGISTRY}"/"${SERVICE_NAME}":"${DOCKER_TAG}"
else
  echo "Skipping deployment..."
fi
