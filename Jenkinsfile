node {
      withEnv(['JIRA_SITE=jira-server']) {
          stage('Checkout') {
              deleteDir()
              git(branch: 'master', url: 'ssh://git@github.com:malovme/test-unit-example.git')
          }

          stage('Tests') {
              /bin/bash -l ruby test.rb
          }
      }
}