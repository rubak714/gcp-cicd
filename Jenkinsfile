pipeline {
  agent any

  environment {
    GCP_PROJECT = 'stable-healer-418019'
    REGION = 'us-central1'
    IMAGE_NAME = "gcr.io/${GCP_PROJECT}/my-flask-app"
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/rubak714/gcp-cicd.git'
      }
    }

    stage('Authenticate with GCP') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          sh '''
            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
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
