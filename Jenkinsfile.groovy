pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                sh 'rm -rf /var/www/horarios-v2/*'
                sh 'cp -r ./* /var/www/horarios-v2/'
            }
        }
    }
}