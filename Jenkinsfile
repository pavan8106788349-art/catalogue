pipeline {
    agent { label 'roboshop' }
    environment {
        appVersion = ""
        ACC_ID = "593300579669"
        AWS_REGION = "us-east-1"
    }
    options {
        // //disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }

    stages{
      stage('Debug Workspace') {
            steps {
                sh '''
                    pwd
                    ls -l
                    find . -name package.json
                '''
            }
        }  
    }
    /* parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Toggle this value')
        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    } */
    stages {
      stage('Read version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    env.appVersion = packageJson.version
                    echo "Version: ${env.appVersion}"
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
                    withAWS(credentials: 'aws-cred', region: "${region}") {
                        // Commands here have AWS authentication
                        sh """
                            aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                            docker build -t ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                            docker push ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion}
                        """
                    }
                }
            }
        }
    }

    // post build
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
