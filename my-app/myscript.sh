#!/bin/bash

# Set your project ID and repository URL
PROJECT_ID="hostinte"
REPO_URL="https://github.com/oyinlola101/test-1.git"

# Set the name of the Dockerfile in the repository
DOCKERFILE_PATH="Dockerfile"

# Set the Cloud Build configuration file (cloudbuild.yaml) in the repository
CLOUDBUILD_CONFIG="cloudbuild.yaml"

# Set the Cloud Storage bucket for Cloud Build artifacts
ARTIFACT_BUCKET="gs://hosinte_cloudbuild"

# Clone the repository
git clone $REPO_URL

cd test-1/my-app

# Authenticate with Google Cloud SDK
gcloud auth login
gcloud config set project hostinte

# Submit the build to Cloud Build
gcloud builds submit --config=$CLOUDBUILD_CONFIG 
# Retrieve the artifact URL from Cloud Build history
BUILD_ID=$(gcloud builds list --limit=1 --format="value(ID)")
BUILD_STATUS=$(gcloud builds describe $BUILD_ID --format="value(status)")
if [ "$BUILD_STATUS" == "SUCCESS" ]; then
  ARTIFACT_URL=$(gcloud builds describe $BUILD_ID --format="value(results.images.artifactRepository)")
  echo "Artifact URL: $ARTIFACT_URL"
else
  echo "Build failed. Check Cloud Build logs for details."
