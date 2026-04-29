pipeline {
    agent { label 'roboshop' }

    environment {
        appVersion = ""
        ACC_ID = "593300579669"
        AWS_REGION = "us-east-1"
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
                    echo "Version: ${appVersion}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build & Push Image') {
            steps {
                script {
                    withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                        sh """
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                            
                            docker build -t ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/roboshop/catalogue:${appVersion} .
                            
                            docker push ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/roboshop/catalogue:${appVersion}
                        """
                    }
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