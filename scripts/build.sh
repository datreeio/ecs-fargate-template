#!/bin/bash
set -ex

# If pull request - quit
if [[ "${TRAVIS_PULL_REQUEST}" == "true" ]]; then
  exit
else
  echo "TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"
fi


REPO_NAME=`echo ${TRAVIS_REPO_SLUG} |awk '{split($0, a, "/"); print a[2]}'`
DOCKER_REGISTRY=<REPLACE>.dkr.ecr.us-east-1.amazonaws.com

# Determine docker tag
if [ "${TRAVIS_PULL_REQUEST}" == "false" ] && [ "${TRAVIS_BRANCH}" == "master" ]; then
  DOCKER_TAG=latest;
  git fetch --tags
  npm run semantic-release
  rm -rf .npmrc
else
  DOCKER_TAG="${TRAVIS_BRANCH}";
fi

echo "Building ${REPO_NAME}:${DOCKER_TAG}"

pip install --user awscli # install aws cli w/o sudo
export PATH=$PATH:$HOME/.local/bin # put aws in the path

echo //registry.npmjs.org/:_authToken=$NPM_TOKEN > .npmrc
eval $(aws ecr get-login --no-include-email --region us-east-1) #needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars
docker build --build-arg NPM_TOKEN=$NPM_TOKEN -t "${REPO_NAME}":"${DOCKER_TAG}" .
docker tag "${REPO_NAME}":"${DOCKER_TAG}" "${DOCKER_REGISTRY}"/"${REPO_NAME}":"${DOCKER_TAG}"
docker push "${DOCKER_REGISTRY}"/"${REPO_NAME}":"${DOCKER_TAG}"
