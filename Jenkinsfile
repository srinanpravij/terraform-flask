pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "vijaya81kp/tfflaskapp"
        CONTAINER_NAME = "tfflaskcontainer"
        PATH = "/usr/local/bin/terraform:$PATH"
        SECRET_FILE_ID = credentials('cptfvarfile')
        DOCKER_REGISTRY_CREDENTIAL = credentials('dockerhub')
    }

    stages {
        stage('Clean') {
            steps {
                script {
                    sh 'rm -rf $WORKSPACE/tfflask'
                    echo 'Inside project clean'
                }
            }
        }

        stage('SVM-Checkout') {
            steps {
                script {
                    sh 'git clone https://github.com/srinanpravij/terraform-flask.git $WORKSPACE/tfflask'
                    sh 'ls'
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    withCredentials([
                        [$class: 'UsernamePasswordMultiBinding', credentialsId: DOCKER_REGISTRY_CREDENTIAL, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']
                    ]) {
                        sh "docker image build . -f $WORKSPACE/tfflask/Dockerfile -t $DOCKER_HUB_REPO"
                        sh "docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER"
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                            sh "docker push $DOCKER_HUB_REPO:$BUILD_NUMBER"
                            sh "docker push $DOCKER_HUB_REPO:latest"
                        }
                    }
                    echo "Image built and pushed to the repository"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    dir('tfflask') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    dir('tfflask') {
                        withCredentials([
                            [$class: 'FileBinding', credentialsId: SECRET_FILE_ID, variable: 'SECRET_FILE']
                        ]) {
                            sh 'terraform plan -var-file=$SECRET_FILE'
                        }
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                script {
                    dir('tfflask') {
                        sh 'terraform validate'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    dir('tfflask') {
                        withCredentials([
                            [$class: 'FileBinding', credentialsId: SECRET_FILE_ID, variable: 'SECRET_FILE']
                        ]) {
                            sh 'terraform apply -var-file=$SECRET_FILE --auto-approve'
                        }
                    }
                }
            }
        }
    }
}
