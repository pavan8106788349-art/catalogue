pipeline {
    agent {
        node {
            label 'roboshop'
        }
    }

    environment {
        appVersion = "1.0"
        ACC_ID = "593300579669"
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }

    stages {

        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    env.appVersion = packageJson.version
                    echo "App version is ${env.appVersion}"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                sh """
                    npm install
                """
            }
        }

        stage('Build docker image') {
            steps {
                sh """
                    withAWS(credentials: 'aws-creds-id , region: 'us-east-1' ){
                    // commands here have AWS authentication
                    sh """
                      aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                      docker build -t ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                      docker push ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} 
                }    
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo "pipeline success"
        }
        failure {
            echo "pipeline failure"
        }
    }
}


