#!/bin/bash
set -ex

source ./data.sh

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

envs=""

for version in "${versions[@]}"; do
  mkdir -p "$version"
  cp --force template/Dockerfile.template "$version/Dockerfile"
  cp --force template/php.ini "$version/php.ini"
  cp --force template/entrypoint "$version/entrypoint"
  sed -ri \
    -e 's!%%STUDIP_VERSION%%!'"$version"'!' \
    -e 's!%%STUDIP_PHP_VERSION%%!'"${php_versions[$version]}"'!' \
    -e 's!%%STUDIP_DOWNLOAD_URL%%!'"${download_urls[$version]}"'!' \
    -e 's!%%STUDIP_ARCHIVE_HASH_SHA1%%!'"${sha1_hashes[$version]}"'!' \
    "$version/Dockerfile"
  envs+="  - VERSION=$version\n"
done

cp --force template/travis.yml.template ./.travis.yml
sed -ri -e 's!%%ENVS%%!'"$envs"'!' ./.travis.yml
