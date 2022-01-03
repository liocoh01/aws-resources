pipeline {
    agent {
        node {
            label 'master'
        }
    }
    options {
        buildDiscarder logRotator(
                    daysToKeepStr: '16',
                    numToKeepStr: '10'
            )
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        GH_TOKEN              = credentials('gh_token')
    }
    stages {
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }
        stage('Testing terraform') {
            steps {
               checkout scm
                 sh """
                   cd terraform
                   terraform init
                   terraform init -force-copy
                   terraform validate
                 """
            }
        }
        stage('Terraform Plan') {
            steps {
                sh """
                  cd terraform
                  terraform plan  -no-color -out=terraform.plan
                """
            }
        }
        stage('Deploy to Production') {
            when {
                branch 'master'
            }
            steps {
              withCredentials([file(credentialsId: 'liorco300-aws.pem', variable: 'FILE')]) {
                sh """
                  cd terraform
                  terraform apply terraform.plan
                """
              }
            }
        }
    }
}
