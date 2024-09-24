#!/bin/bash
#author: Ramesh Godishela
#date: Sep 24 2024
#purpose: Move Forks Between Organizations

move_repo() {
  SOURCE_ORG=$1
  REPO_NAME=$2
  TARGET_ORG=$3

  echo "Cloning the repository $REPO_NAME from $SOURCE_ORG..."
  git clone https://github.com/$SOURCE_ORG/$REPO_NAME.git

  cd $REPO_NAME || { echo "Failed to access repo directory"; exit 1; }

  echo "Setting new remote to target organization $TARGET_ORG..."
  git remote set-url origin https://github.com/$TARGET_ORG/$REPO_NAME.git

  echo "Pushing repository to $TARGET_ORG..."
  git push -u origin main

  echo "Pushing all branches and tags..."
  git push --all
  git push --tags

  cd ..

  echo "Cleaning up..."
  rm -rf $REPO_NAME

  echo "Repository $REPO_NAME moved successfully from $SOURCE_ORG to $TARGET_ORG!"
}

# Main Script
# Define source org, target org, and repo you want to move
SOURCE_ORG="source-org"
TARGET_ORG="target-org"

# List of repositories to move
REPO_LIST=("repo1" "repo2" "repo3")

# Loop through each repository and move it
for REPO_NAME in "${REPO_LIST[@]}"; do
  move_repo $SOURCE_ORG $REPO_NAME $TARGET_ORG
done
