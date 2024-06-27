pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '''
                    #!/bin/bash
                    /opt/maven/bin/mvn clean install -Dmaven.test.skip=true
                '''
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.war'
            }
        }

        stage('Build image') {
            steps {
                script {
                    app = docker.build("jenkinsci-cd/webserver")
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://localhost:5000', 'docker-credentials') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Create Docker Registry Secret') {
            steps {
                script {
                        sh """
                        kubectl create secret docker-registry docker-registry-secret \
                          --docker-server=http://localhost:5000 \
                          --docker-username=admin \
                          --docker-password=admin \
                          --docker-email=you@example.com \
                          --dry-run=client -o yaml | kubectl apply -f -
                        """
                    }
                
            }
        }

        stage('Deploy on K8') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
