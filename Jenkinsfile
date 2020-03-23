node {
      withEnv(['JIRA_SITE=jira-server']) {
          stage('Checkout') {
              deleteDir()
              checkout scm
          }

          stage('Tests') {
          bash '''#!/bin/bash
                  ruby -v
               '''
          }
      }
}