pipeline {
    agent {
        node {
            label 'roboshop'
        }
    }

    environment {
        COURSE = "Jenkins"
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }

    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Toggle this value')
        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }

    stages {
        stage('Build') {
            steps {
                sh """
                    echo "Testing"
                    echo "Hello $PERSON"
                    echo "Biography: $BIOGRAPHY"
                    echo "Deploy Toggle: $DEPLOY"
                    echo "Choice: $CHOICE"
                    echo "Password: $PASSWORD"
                """
            }
        }

        stage('Test') {
            steps {
                sh """
                    echo "Testing Stage"
                    echo "Course: $COURSE"
                """
            }
        }

        stage('Deploy') {
            when {
                expression { params.DEPLOY == true }
            }
            steps {
                input message: "Should we continue?", ok: "Yes"
                sh """
                    echo "Deploying application..."
                """
            }
        }
    }

    post {
        always {
            echo 'I will always say Hello again!'
        }
        success {
            echo "pipeline success"
        }
        failure {
            echo "pipeline failure"
        }
    }
}
