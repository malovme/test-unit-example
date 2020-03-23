def runInBash(command) {
    sh """#!/bin/bash -l
        set -x
        ${command}
    """
}

node {
      withEnv(['JIRA_SITE=jira-server']) {
          stage('Checkout') {
              deleteDir()
              checkout scm
          }

          stage('Tests') {
              runInBash('ruby test.rb')
          }
      }
}