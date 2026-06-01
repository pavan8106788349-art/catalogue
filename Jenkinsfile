@Library('jenkins-test-library') _

def configMap = [
<<<<<<< HEAD
<<<<<<< HEAD
    project: "roboshop",
=======
    project: "roboshop" ,
>>>>>>> 690035f (jenkins)
    component: "catalogue"
=======
    "project": "roboshop",
    "component": "catalogue"
>>>>>>> f45a493 (jenkins)
]

pipeline {
    agent any

<<<<<<< HEAD
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
=======
if (env.BRANCH_NAME.equalsIgnoreCase('main')) {
    echo "checking later"
} else {
    testPipeline(configMap)
}
>>>>>>> f45a493 (jenkins)
