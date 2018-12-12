#!/usr/bin/env bash

# Before running this script first pull the latest changes and commit your changes.
#
#The release process contains of the following two steps:
#
# 1 The buildnumber is increased in the root POM and also in the aggregated sub-projects root POM's. The new buildNumber is stored in the buildNumber.properties file.
#   The updated POM's and the buildNumber.properties file are committed with a comment with the updated version information.
#   Then a new Git tag with the new version number is set. The branch is then pushed to the remote.
#
#   Before you release (run this script), you must pull the latest changes and check wether you have pending changes via the 'git status' command.
#   So when you perform a 'git status', then the message 'nothing to commit, working directory clean' should be shown.
#   Running this script will first check for local changes and fails if working directory is not clean.
#   After the check for local changes, the script will check if there are no SNAPSHOTS in the project. It fails when the project contains a SNAPSHOT version.
#
# 2 The pipeline (if exist) will start because of the changed tagged branch.
#

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