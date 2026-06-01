@Library('jenkins-test-library') _

def configMap = [
    project: "roboshop",
    component: "catalogue"
]

pipeline {
    agent any

    stages {
        stage('Run Shared Library') {
            steps {
                script {
                    echo "Triggering the Library pipeline"

                    if (env.BRANCH_NAME?.equalsIgnoreCase('main')) {
                        echo "checking later"
                    } else {
                        testPipeline(configMap)
                    }
                }
            }
        }
    }
}
