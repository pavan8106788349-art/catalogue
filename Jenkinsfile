pipeline {
    agent {
        node {
            label 'ROBOSHOP'
        }
    }

    environment {
        appVersion = ""
        ACC_ID = "353617811136"
        AWS_REGION = "us-east-1"
    }

    options {
        /* disableConcurrentBuilds() */
        timeout(time: 5, unit: 'MINUTES')
    }

    stages {

        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'

                    appVersion = packageJson.version

                    echo "Building version ${appVersion}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    withAWS(
                        credentials: "Aws-creds",
                        region: "${AWS_REGION}"
                    ) {
                        sh """
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

                            docker build -t ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/roboshop/catalogue:${appVersion} .

                            docker push ${ACC_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/roboshop/catalogue:${appVersion}
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression {
                    "${params.DEPLOY}" == "true"
                }
            }

            steps {
                script {
                    sh """
                        echo "Deploying"
                    """
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
