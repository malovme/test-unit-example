def runInBash(command) {
    sh """#!/bin/bash -l
        set -x
        ${command}
    """
}

node {
    withEnv(['JIRA_SITE=jira-server']) {
        try {
            stage('Checkout') {
                deleteDir()
                checkout scm
            }

            stage('Tests') {
                runInBash('ruby test.rb')
            }
        } finally {
            archiveArtifacts artifacts: 'build/libs/**/*.jar', fingerprint: true
            junit 'build/reports/**/*.xml'
        }
    }
}
