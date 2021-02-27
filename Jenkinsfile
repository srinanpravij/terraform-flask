pipeline{
agent any
	environment{
	DOCKER_HUB_REPO = "vijaya81kp/tfflaskapp"
	REGISTRY_CREDENTIAL = "dockerhub"
	CONTAINER_NAME = "tfflaskcontainer"
	dockerImage = ''
	PATH = "/usr/local/bin/terraform:$PATH"
	SECRET_FILE_ID = credentials('tfsecret')
	//ANS_HOME = tool('ansible')
	}
	tools {
        terraform 'Terraform'
    }

	stages{
		stage('Clean'){
		steps{
			script{
				sh 'rm -rf $PWD/tfflask'
				echo 'inside project clean'
				}
			}
		}
	stage('SVM-Checkout'){
		steps{
			script{
				sh 'git clone https://github.com/srinanpravij/terraform-flask.git $PWD/tfflask'
				sh 'ls'
				}
			}
		}
	stage('Build Image') {
		steps {
			script {
				sh 'env'
				sh 'pwd'
				// Building new image
				//sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
				sh 'docker image build . -f ./tfflask/Dockerfile -t vijaya81kp/tfflaskapp'
				sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'
				// Pushing Image to Repository
				docker.withRegistry( '', REGISTRY_CREDENTIAL ) {	
				sh 'docker push vijaya81kp/tfflaskapp:$BUILD_NUMBER'
				sh 'docker push vijaya81kp/tfflaskapp:latest'
				}

				echo "Image built and pushed to repository"
			}
		}
	}
		stage('Terraform Init'){
            steps {
                // Initialize terraform with all the required plugin
				sh 'pwd'
                script{
					dir('capstone'){
						sh 'terraform init'
						}
				}
                
            }
        }
		stage('Terraform apply'){
            steps {
                // Initialize terraform with all the required plugin
				sh 'env'
                script{
					dir('capstone'){
						//sh 'terraform apply --auto-approve'
						sh 'terraform apply -var-file=${SECRET_FILE_ID} --auto-approve'
						}
				}
                
            }
        }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//stage('Deploy-Playbook'){
// steps{
// ansiblePlaybook credentialsId: 'capstone', disableHostKeyChecking: true, installation: 'ansible', playbook: './2020_03_DO_Boston_casestudy_part_1/ansible.yaml'
// }
//}
}

}