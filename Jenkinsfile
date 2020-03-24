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

            stage('Bundle install') {
                runInBash('bundle install')
            }

            stage('Tests')
                runInBash('ruby test.rb --runner=junitxml --junitxml-output-file=result.xml')
            }
        } finally {
            junit 'build/reports/**/*.xml'
        }
    }
}
