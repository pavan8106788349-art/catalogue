pipeline {
    agent {
        node {
            label 'ROBOSHOP'
        }
    }
    environment {
        appVersion = ""
    }

    options {
        // disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }  

    /* parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Toggle this value')
        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }  */

    stages {
        stage('Read version') {
            steps {
                script {
                    // Load and parse json file
                    def packageJson = readJSON file: 'package.json'
                    
                    // Extract properties using dot notation
                    appVersion = packageJson.version
                    echo "Building ${appName} version ${appVersion}"
                }    }    
        }
        stage('Install dependencies') { 
            steps {
                script{
                    sh '''
                       npm install
                    '''
                }
            }
        }

        stage('Build Image') { 
            steps {
                script{
                    sh """
                      docker build -t catalogue:${appVersion}
                    """
                }
            }
        }
        stage('Deploy') {
            when {
                expression { "${params.DEPLOY}" == "true" }
            }

            /* input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            } */

        stage('Deploy') { 
            steps {
                script{
                    sh '''
                     echo "Deploying" 
                    '''
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
