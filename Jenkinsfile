pipeline {
  agent any

  environment {
    GCP_PROJECT = 'stable-healer-418019'
    REGION      = 'us-central1'
    IMAGE_NAME  = "gcr.io/${GCP_PROJECT}/my-flask-app"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/rubak714/gcp-cicd.git'
      }
    }

    stage('Authenticate with GCP') {
      steps {
        withCredentials([string(credentialsId: 'gcp-sa-key', variable: 'SA_JSON')]) {
          writeFile file: 'sa.json', text: SA_JSON
          sh '''
            gcloud auth activate-service-account --key-file=sa.json
            gcloud config set project $GCP_PROJECT
          '''
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME .'
      }
    }

    stage('Push Docker Image') {
      steps {
        sh '''
          gcloud auth configure-docker --quiet
          docker push $IMAGE_NAME
        '''
      }
    }

    stage('Deploy to Cloud Run') {
      steps {
        sh '''
          gcloud run deploy my-flask-app \
            --image $IMAGE_NAME \
            --platform managed \
            --region $REGION \
            --allow-unauthenticated
        '''
      }
    }
  }
}
