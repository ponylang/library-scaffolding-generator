#!/bin/bash

set -o errexit
set -o nounset

### Variables to replace

# GitHub user or organization that owns the project
# https://github.com/OWNER/project
# Unless this library is part of an organization, this should be your username.g
REPO_OWNER="ponylang"
# Name of the project
# https://github.com/ponylang/NAME
REPO_NAME="crypto"
#
PACKAGE="crypto"
#
PROJECT_DESCRIPTION="Library of common cryptographic algorithms and functions for Pony."
#
PROJECT_STATUS="${REPO_NAME} is pre-alpha software."
# GitHub user to access GitHub API as. Will need to provide a
# personal access token that allows read/write access to the repository.
# Unless this library is part of an organization, this should be your username.
GITHUB_USER="ponylang-main"
# Email address to associate with commits made by GITHUB_USER
# Unless this library is part of an organization, this should be your email.
COMMIT_EMAIL="ponylang.main@example.com"
# Name to associate with commits made by GITHUB_USER
# Unless this library is part of an organization, this should be your name.
COMMIT_NAME="Main"
# Copyright year for the License
COPYRIGHT_YEAR="2019"
# Copyright holder for the License
COPYRIGHT_HOLDER="The Pony Developers"
# email address that users should use to report code of conduct violations
COC_EMAIL="coc@example.com"

## TODO: verify $1

TARGET_DIR=$1

# create target directory if it doesn't already exist
mkdir -p "${TARGET_DIR}"

# Move to the base project directory if not there already.
#pushd "$(dirname "$0")" || exit 1

# copy all files
pushd "src" || exit 1
cp -r --copy-contents -t "${TARGET_DIR}" .
popd || exit

for file in $(find "${TARGET_DIR}")
do
  echo "${file}"
  if ! [ -d "${file}" ]
  then
    sed -i s/"{%%REPO_OWNER%%}"/"${REPO_OWNER}"/g "${file}"
    sed -i s/"{%%REPO_NAME%%}"/"${REPO_NAME}"/g "${file}"
    sed -i s/"{%%PACKAGE%%}"/"${PACKAGE}"/g "${file}"
    sed -i s/"{%%PROJECT_DESCRIPTION%%}"/"${PROJECT_DESCRIPTION}"/g "${file}"
    sed -i s/"{%%PROJECT_STATUS%%}"/"${PROJECT_STATUS}"/g "${file}"
    sed -i s/"{%%GITHUB_USER%%}"/"${GITHUB_USER}"/g "${file}"
    sed -i s/"{%%COMMIT_EMAIL%%}"/"${COMMIT_EMAIL}"/g "${file}"
    sed -i s/"{%%COMMIT_NAME%%}"/"${COMMIT_NAME}"/g "${file}"
    sed -i s/"{%%COPYRIGHT_YEAR%%}"/"${COPYRIGHT_YEAR}"/g "${file}"
    sed -i s/"{%%COPYRIGHT_HOLDER%%}"/"${COPYRIGHT_HOLDER}"/g "${file}"
    sed -i s/"{%%COC_EMAIL%%}"/"${COC_EMAIL}"/g "${file}"
  fi
done

# Deal with special gitfile that we needed to give special names to
mv "${TARGET_DIR}/gitattributes" "${TARGET_DIR}/.gitattributes"
mv "${TARGET_DIR}/gitignore" "${TARGET_DIR}/.gitignore"

# create PACKAGE directory
mkdir -p "${TARGET_DIR}/${PACKAGE}"
