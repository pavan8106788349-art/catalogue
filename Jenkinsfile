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
        /* disableConcurrentBuilds() */
        timeout(time: 5, unit: 'MINUTES')
    }

    /* parameters {
        string(
            name: 'PERSON',
            defaultValue: 'Mr Jenkins',
            description: 'Who should I say hello to?'
        )

        text(
            name: 'BIOGRAPHY',
            defaultValue: '',
            description: 'Enter some information about the person'
        )

        booleanParam(
            name: 'DEPLOY',
            defaultValue: false,
            description: 'Toggle this value'
        )

        choice(
            name: 'CHOICE',
            choices: ['One', 'Two', 'Three'],
            description: 'Pick something'
        )

        password(
            name: 'PASSWORD',
            defaultValue: 'SECRET',
            description: 'Enter a password'
        )
    } */

    stages {
        stage('Read Version') {
            steps {
                script {
                    // Load and parse JSON file
                    def packageJson = readJSON file: 'package.json'
                    
                    // Access fields directly
                    def appVersion = packageJson.version
                    echo "Building version ${appVersion}"
                }    }        
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
                    withAWS(credentials: "aws-creds", region: "us-east-1") {
                    sh """
                        aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin 353617811136.dkr.ecr.us-east-1.amazonaws.com
                        docker build -t ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion} .
                        docker push ${ACC_ID}.dkr.ecr.${region}.amazonaws.com/roboshop/catalogue:${appVersion}
                    """
                }
            }
        }

        stage('Deploy') {
            when {
                expression {  "${params.DEPLOY}" == "true" }
            }
            // input {
            //     message "Should we continue?"
            //     ok "Yes, we should."
            //     submitter "alice,bob"

            //     parameters {
            //         string(
            //             name: 'PERSON',
            //             defaultValue: 'Mr Jenkins',
            //             description: 'Who should I say hello to?'
            //         )
            //     }
            // }

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