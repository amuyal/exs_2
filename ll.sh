#!/bin/bash -x
#this is a simple CI script

GIT_REPO_URI=https://github.com/zivkashtan/course.git
LOCAL_DIR="/home/student/Desktop/pro/exs_2/course/"
MVN_ACTION="package"
ARTIFACT_GROUP_ID="clinic.programming.time-tracker"
ARTIFACT_ID="time-tracker-parent"
ARTIFACT_VERSION="0.3.1"
ARTIFACT_Dpackaging="pom"
ARTIFACT_file="output/timetracker.war"
NEXUS_REPO_URL="https://localhost:8081/repository/maven-snapshots"

function clean(){  
  rm -rf "$LOCAL_DIR"	
}

function sourceCodePull(){  
  git clone "$GIT_REPO_URI"
  echo "****pulled****"
}


function build(){  
  cd "$LOCAL_DIR"
  mvn "$MVN_ACTION"
  echo "****build****"
}

function artifactPublishing(){  
  mvn deploy:deploy-file \
  DgroupId=clinic.programming.time-tracker \
  DartifactId=time-tracker-parent \
  Dversion=0.3.1 \
  Dpackaging=pom \
  Dfile=output/timetracker.war \
  Durl=https://localhost:8081/repository/maven-snapshots/
  echo "artifactPublishing"
}

function main(){
  clean
  sourceCodePull
  preBuildConfig
  build
  artifactPublishing
}
main
