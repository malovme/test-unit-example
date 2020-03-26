def runInBash(command) {
    sh """#!/bin/bash -l
        set -x
        ${command}
    """
}

def getFailedTestsFrom(build) {
    // RawBuild has to be set to a local variable before getAction can be called one it.
    def rawBuild = build.rawBuild
    def testResults = rawBuild.getAction(hudson.tasks.junit.TestResultAction.class)
    if (testResults == null) {
        return []
    } else {
        return testResults.getFailedTests()
    }
}

node {
    withEnv(['JIRA_SITE=jira-server']) {
        stage('Checkout') {
            deleteDir()
            checkout scm
        }

        stage('Bundle install') {
            runInBash('bundle install')
        }

        try {
            stage('Tests') {
                runInBash('ruby test.rb --runner=junitxml --junitxml-output-file=result.xml')
            }
        } catch(e) {
            currentBuild.result = 'FAILURE'
        } finally {
            junit 'result.xml'
        }

        stage('Pesterbot') {
            def failedTests = getFailedTestsFrom(currentBuild).collect { failedTest ->
                    failedTest.testName.split("\\(")[0]
            }
            if (failedTests) { // collection is false if empty
                println "${failedTests.join(', ')} failed in ${currentBuild.getAbsoluteUrl()}"
                failedTests.each { failedTest ->
                    def issues = jiraJqlSearch(
                                    //fields: ['key', 'summary'],
                                    jql: "PROJECT = CL AND SUMMARY ~ 'Test ${failedTest} is failing"'"
                                 ).data.issues
                    def issueKeys = issues.collect { issue -> issue.key }
                    if (issueKeys) {
                        // make comment
                        issueKeys.each { issueKey ->
                            def comment = [ body: "Test failed in ${env.BUILD_URL}" ]
                            jiraAddComment idOrKey: issueKey, input: comment
                        }
                    } else {
                        // create new ticket
                        def issue = [fields: [
                                     project: [key: 'CL'],
                                     summary: "Test ${failedTest} is failing",
                                     description: "Test failed in ${env.BUILD_URL}",
                                     issuetype: [id: '10004']]]
                        jiraNewIssue issue: issue
                    }
                }
            }
        }
    }
}
