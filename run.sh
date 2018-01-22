#!/usr/bin/env bash

echo "Checking local environment variables are set"
if [[ -z "${SYNC_URL}" ]]; then
  echo "Please set the SYNC_URL env var"
else
  echo "SYNC_URL=$SYNC_URL"
fi

if [[ -z "${FIND_URL}" ]]; then
  echo "Please set the FIND_URL env var"
else
  echo "FIND_URL=$FIND_URL"
fi

if [[ -z "${PUBLISH_URL}" ]]; then
  echo "Please set the PUBLISH_URL env var"
else
  echo "PUBLISH_URL=$PUBLISH_URL"
fi

if [[ -z "${CKAN_API_KEY}" ]]; then
  echo "Please set the CKAN_API_KEY env var"
else
  echo "CKAN_API_KEY=$CKAN_API_KEY"
fi

if [[ -z "${LEGACY_LOGIN_USERNAME}" ]]; then
  echo "Please set the LEGACY_LOGIN_USERNAME env var"
else
  echo "LEGACY_LOGIN_USERNAME=$LEGACY_LOGIN_USERNAME"
fi

if [[ -z "${LEGACY_LOGIN_PASSWORD}" ]]; then
  echo "Please set the LEGACY_LOGIN_PASSWORD env var"
else
  echo "LEGACY_LOGIN_PASSWORD=$LEGACY_LOGIN_PASSWORD"
fi

if [[ -z "${PUBLISH_BETA_BASIC_AUTH_USERNAME}" ]]; then
  echo "Please set the PUBLISH_BETA_BASIC_AUTH_USERNAME env var"
else
  echo "PUBLISH_BETA_BASIC_AUTH_USERNAME=$PUBLISH_BETA_BASIC_AUTH_USERNAME"
fi

if [[ -z "${PUBLISH_BETA_BASIC_AUTH_PASSWORD}" ]]; then
  echo "Please set the PUBLISH_BETA_BASIC_AUTH_PASSWORD env var"
else
  echo "PUBLISH_BETA_BASIC_AUTH=$PUBLISH_BETA_BASIC_AUTH_PASSWORD"
fi

if [[ -z "${PUBLISH_BETA_LOGIN_USERNAME}" ]]; then
  echo "Please set the PUBLISH_BETA_LOGIN_USERNAME env var"
else
  echo "PUBLISH_BETA_LOGIN_USERNAME=$PUBLISH_BETA_LOGIN_USERNAME"
fi

if [[ -z "${PUBLISH_BETA_LOGIN_PASSWORD}" ]]; then
  echo "Please set the PUBLISH_BETA_LOGIN_PASSWORD env var"
else
  echo "PUBLISH_BETA_LOGIN_PASSWORD=$PUBLISH_BETA_LOGIN_PASSWORD"
fi

echo "Running end to end tests"
rspec
echo "Done"







