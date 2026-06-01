@Library('jenkins-test-library') _

def configMap = [
<<<<<<< HEAD
    project: "roboshop",
=======
    project: "roboshop" ,
>>>>>>> 690035f (jenkins)
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
