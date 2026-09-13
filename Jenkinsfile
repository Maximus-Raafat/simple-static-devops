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
        	withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            	sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                docker tag my-static-site $DOCKER_USER/static-site-pipeline:latest
                docker push $DOCKER_USER/static-site-pipeline:latest
            '''
        }
    }
}
             
 
        
    }
}
