pipeline {
    agent any

    environment {
        //docker ka username
        IMAGE_NAME = 'aradhya06/flask-login-app'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Aradhya-06/flask-login-jenkins.git'
            }
        }
        stage('Python Tests') {
            steps {
                sh '''
                python -m venv venv
                ./venv/Scripts/activate
                pip install -r requirements.txt
                python -m py_compile app.py
                '''
            }
        }
        stage('Docker Build') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME:latest .
                '''
                
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: '6b2cfae1-f6e0-49ef-bbe8-b11bb761011b', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }
        stage('Docker Push') {
            steps {
                sh '''
                docker push $IMAGE_NAME:latest
                '''
            }
        }
        stage('Docker Deploy'){
            steps {
                sh '''
                docker compose down || true
                docker compose up -d --build
                '''
            }
        }
    }
}