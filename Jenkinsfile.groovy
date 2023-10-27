pipeline {
    agent any
    environment {
        PATH = "/var/lib/jenkins/.nvm/versions/node/v20.9.0/bin:/var/lib/jenkins/bin:${env.PATH}"
    }
    stages {
        stage('Install') {
            steps {
                sh 'pnpm i'
            }
        }
        stage('Build') {
            steps {
                sh 'pnpm build'
            }
        }
        stage('Deploy') {
            steps {
                sh 'rm -rf /var/www/horarios-v2/*'
                sh 'cp -r ./dist/* /var/www/horarios-v2/'
            }
        }
    }
}