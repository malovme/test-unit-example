def rvmSh(String cmd) {
    def sourceRvm = 'source /etc/profile.d/rvm.sh'
    def useRuby = "rvm use ruby-2.6.5"
    sh "${sourceRvm}; ${useRuby}; $cmd"
}

node {
      withEnv(['JIRA_SITE=jira-server']) {
          stage('Checkout') {
              deleteDir()
              checkout scm
          }

          stage('Tests') {
              rvmSh 'ruby test.rb'
          }
      }
}