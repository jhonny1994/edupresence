#!/bin/bash

# Check if version is provided
if [ -z "$1" ]; then
    echo "Please provide a version number (e.g., ./release.sh 1.0.0)"
    exit 1
fi

VERSION=$1

# Ensure we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "Please switch to main branch first"
    exit 1
fi

# Ensure the working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is not clean. Please commit or stash changes first."
    exit 1
fi

# Pull latest changes
echo "Pulling latest changes..."
git pull origin main

# Prepare release
echo "Preparing release..."
melos run release:prepare

# Update version
echo "Updating version to $VERSION..."
melos run version $VERSION

# Commit version bump
git add .
git commit -m "chore: bump version to $VERSION"

# Create and push tag
echo "Creating tag v$VERSION..."
git tag -a "v$VERSION" -m "Release version $VERSION"

# Push changes and tag
echo "Pushing changes and tag..."
git push origin main
git push origin "v$VERSION"

echo "Release $VERSION prepared and pushed!"
echo "GitHub Actions will now:"
echo "1. Build Android and Windows apps"
echo "2. Create a draft release with the builds"
echo "3. Generate release notes"
echo ""
echo "Please review and publish the draft release on GitHub when ready."
