#!/bin/bash

branch=$(git rev-parse --abbrev-ref HEAD)
series=$(echo $branch | cut -d  "-" -f2)
varfile=redhat/Makefile.variables

sed -i "s,BUMP_RELEASE:=yes,BUMP_RELEASE:=no," $varfile
sed -i "s,os-build,$branch," $varfile
sed -i "s,RELEASED_KERNEL:=0,RELEASED_KERNEL:=1," $varfile
sed -i "s,UPSTREAM_BRANCH ?= master,UPSTREAM_BRANCH ?= linux-$series.y," $varfile

cp redhat/scripts/fedora/release_targets redhat/release_targets
cp redhat/scripts/fedora/BugsFixed redhat/BugsFixed
cp redhat/scripts/fedora/fedora-srpm.sh redhat/fedora-srpm.sh
cp redhat/scripts/fedora/fedora-stable-release.sh redhat/fedora-stable-release.sh

git add redhat/Makefile.variables redhat/release_targets redhat/BugsFixed redhat/fedora-srpm.sh redhat/fedora-stable-release.sh

echo "Please verify Fedora versions in redhat/fedora-stable-release.sh redhat/fedora-srpm.sh and redhat/release_targets before commit"
