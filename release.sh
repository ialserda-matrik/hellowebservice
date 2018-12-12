#!/usr/bin/env bash

#The release process contains of the following two steps:
#
# 1 The buildnumber is increased and the Git tag is set. This step is performed by this script.
#   You should at least increase the buildnumber before pushing your changes! Otherwise the build pipeline wil fail since
#   the deliverables can only be created once per buildnumber.
#
#   Before you release (run this script), you must pull the latest changes and check wether you have pending changes via the 'git status' command.
#   So when you perform a 'git status', then the message 'nothing to commit, working directory clean' should be shown.
#   Running this script will first check for local changes and fails if working directory is not clean.
#   After the check for local changes, the script will check if there are no SNAPSHOTS in the project. It fails when the project contains a SNAPSHOT version.
#   After the check for SNAPSHOTS the script the script increased the version number in all the POM's of the project.
#
#
#
# 2 The build pipeline on the buildserver builds basde on the latest tagged version.
mvn clean validate -Prelease

STATUS=$?
if [ $STATUS -eq 0 ]; then
    test=$(grep -om1  "<major.version>" pom.xml)
    # major=$(grep -om1 "(?<=<major\.version>)[^<]+" pom.xml)
    # minor=$(grep -om1 "(?<=<minor\.version>)[^<]+" pom.xml)
    . buildNumber.properties

    git commit -a -m "Upgrade build number $major.$minor-b$buildNumber"
    mvn clean validate -Ptag
    git push --follow-tags

    echo "test: $test"
else
    echo "Validating the realease failed"
fi