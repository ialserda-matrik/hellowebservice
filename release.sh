#!/usr/bin/env bash

#The release process contains of the following two steps:
# 1 The buildnumber is increased and the Git tag is set. This step is performed by this script.
#   You should at least increase the buildnumber before pushing your changes! Otherwise the build pipeline wil fail since
#   the deliverables can only be created once per buildnumber.
#
#   Before you release, you must pull the latest changes and check wether you have pending changes via the 'git status' command.
#
#   So when you perform a 'git status', then the message 'nothing to commit, working directory clean' should be shown.
#
# 2 The build pipeline on the buildserver builds basde on the latest tagged version.
mvn clean validate -Prelease