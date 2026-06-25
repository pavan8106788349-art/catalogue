pipeline {
    agent {
        node {
            label 'ROBOSHOP'
        }
    }

    environment {
        appVersion = ""
        ACC_ID = "353617811136"
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
    }  

    stages {
        stage('Read version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "Building version ${appVersion}"
                }
            }    
        }

        stage('Install dependencies') { 
            steps {
                script {
                    sh 'npm install'
                }
            }
        }

        stage('Build Image') { 
            steps {
                script {
                     withAWS(credentials: 'aws-creds', region: "us-east-1") {
                        // Commands here have AWS authentication
                        sh """
                            aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                            docker build -t ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                            docker push ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion}
                        }   
                    }
                }
            }
        }

    
        stage('Deploy') {
            when {
                expression { params.DEPLOY == true }
            }
            steps {
                script {
                    sh 'echo "Deploying"'
                }
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