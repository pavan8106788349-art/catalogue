pipeline {
    agent { label 'roboshop' }

    environment {
        appVersion = ""
        ACC_ID = "593300579669"
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

        stage('Build Image') {
            steps {
                script{
                    withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                      // commands here have AWS authentication
                      sh """
                         aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ACC-ID}.dkr.ecr.us-east-1.amazonaws.com 
                         docker build -t ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                         docker push ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion}
                        """                   
                }
                sh "docker build -t catalogue:${appVersion} ."
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