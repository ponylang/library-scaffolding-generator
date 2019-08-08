#!/bin/bash

set -o errexit
set -o nounset

# Bring in user specific configuration
source config.bash

## TODO: verify $1
if [ $# != 1 ]
then
  echo "usage: generated-library.bash TARGET"
  exit 1
fi

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
