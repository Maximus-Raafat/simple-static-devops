pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t my-static-site .'
            }
        }
        stage('Push') {
            steps {
                sh 'echo "هنضيف هنا رفع الـ image بعدين"'
            }
        }
    }
}
