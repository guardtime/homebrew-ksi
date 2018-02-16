#!/bin/bash

#
# Copyright 2013-2018 Guardtime, Inc.
#
# This file is part of the Guardtime client SDK.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES, CONDITIONS, OR OTHER LICENSES OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
# "Guardtime" and "KSI" are trademarks or registered trademarks of
# Guardtime, Inc., and no license to trademarks is granted; Guardtime
# reserves and retains all trademark rights.
#

set -e

 if [ "$#" -eq 3 ]; then
    repo="$1"
    tag_name_header="$2"
    formula_path="$3"
 else
    echo "Usage:"
	echo "  $0 <repo_short_name> <tag_header> <formula_path>"
	echo ""
	echo "Description:"
	echo "  Script that refreshes Homebrew formula from a given Github repository."
	echo "  It updates the URL and hash value of the tarball containing the projects release."
	echo ""
	echo " This script only works if:"
    echo "  * Release is in 'master' branch."
	echo "  * All releases are tagged with names formatted as <header><version>,"
	echo "    for example (v1.5.78)."
	echo "  * Master branch contains file 'VERSION' (containing e.g. 1.5.78)."
	echo ""
	echo ""
	echo "Fields:"
	echo "  repo_short_name"
	echo "       - Repository name from github where 'repo' is part from the full URL"
	echo "         https://github.com/<repo>. That URL is used to download mandatory VERSION"
	echo "         file from master branch to determine the released tag name."
	echo "         Example 'my_github_account/my_repo' forms 'https://github.com/my_github_account"
	echo "         /my_repo'"
	echo ""
	echo "  tag_header"
	echo "       - The header that forms the tag name (under github releases) when it is"
	echo "         concatenated with version string extracted from the mandatory VERSION file."
	echo "         For example header 'test-project-release-' forms  test-project-release-1.5.78.tar.gz."
	echo ""
    echo "  formula_path"
	echo "        - Path to the formula name describing repository specified by repo field."
    exit
 fi

function cleanup {
  rm -f VERSION
  rm -f $tarball
  rm -f tmp.rb
}
trap cleanup EXIT

# Get the mandatory VERSION file from repository. Extract version string and construct
# release name, tarball file name and url to the released content.
wget --no-verbose -q https://raw.githubusercontent.com/$repo/master/VERSION
tarball_version=$(tr -d [:space:] < VERSION)
tarball=$tag_name_header$tarball_version.tar.gz
tarball_url=https://github.com/$repo/archive/$tarball
wget --no-verbose -q $tarball_url

# Calculate hash value of the tarball.
if command  -v shasum > /dev/null; then
  tarball_hash=$(shasum -a 256 $tarball | cut -d " " -f1)
elif command -v sha256sum > /dev/null; then
  tarball_hash=$(sha256sum  $tarball | cut -d " " -f1)
fi

# Make a temporary formula file.
cp $formula_path tmp.rb

# Extract old values from the formula.
old_url=$(grep -Po 'url[^"]*"\K[^"]*' tmp.rb)
old_hash=$(grep -Po 'sha256[^"]*"\K[^"]*' tmp.rb)
old_version=$(echo $old_url | grep -Po "[0-9]{1,2}[.][0-9]{1,3}[.][0-9]{1,4}")
old_repo=$(echo $old_url | grep -oP "(?<=github.com/).*(?=/archive)")

# Break versions to components. 
VER_COMPO_OLD=($(echo $old_version | tr "." " "))
VER_COMPO_NEW=($(echo $tarball_version | tr "." " "))

# Check if repositories do match.
if [ "$old_repo" != "$repo" ]; then
	>&2 echo "Error:"
	>&2 echo "  Repositories are different! Make sure that the Formula matches with the repository!"
	>&2 echo "    formula: '$formula_path'"
	>&2 echo "    old repository: '$old_repo'"
	>&2 echo "    new repository: '$repo'"
	>&2 echo "    old tarball url: '$old_url'"
	>&2 echo "    new tarball url: '$tarball_url'"
	exit 1
fi

# Check if there are some changes in version and hash.
if [ "$old_version" == "$tarball_version" ]; then
	if [ "$old_hash" != "$tarball_hash" ]; then
		>&2 echo "Error:"
		>&2 echo "  Version of the package is not changed, but the package hash value is!"
		>&2 echo "  old hash: $old_hash"
		>&2 echo "  new hash: $tarball_hash"
		exit 1
	else
		echo "OK. Formula is NOT modified ('$formula_path'), as upstream Version has not changed ($old_version)."
		exit 0
	fi
fi

# Check the version. Old version must be equal or less than the new version.
i=0
while [ $i -lt 2 ]; do
	if [ ${VER_COMPO_OLD[$i]} -gt ${VER_COMPO_NEW[$i]} ]; then
		>&2 echo "Error:"
		>&2 echo "  Old Version can not be larger than the new version!"
		>&2 echo "    old version: $old_version"
		>&2 echo "    new version: $tarball_version"
		exit 1
	fi
	i=$((i + 1))
done;


# if [ "$old_url" == "$tarball_url" ]; then
	# >&2 echo "Error: Tarball URL is not changed. Are You sure that the new release is made?"
	# exit 1
# fi

# if [ "$old_hash" == "$tarball_hash" ]; then
	# >&2 echo "Error: Tarball URL is changed but the hash value is the same!"
	# exit 1
# fi


sed -i "s|url.*|url \"$tarball_url\"|g" tmp.rb
sed -i "s|sha256.*|sha256 \"$tarball_hash\"|g" tmp.rb
cp tmp.rb $formula_path
echo "OK. Formula is changed ('$formula_path'). $old_version -> $tarball_version."


exit 0