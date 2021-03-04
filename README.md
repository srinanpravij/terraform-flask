# Vijayalakshmi Kuppuswamy
<h2>Capstone Project 2 - Provisioning and Monitoring</h2>
<h2>Design Document</h2>
<h3>
  <ol>
  <li>Capstone Project Technological Tool Stack:To build the python flask app using the DevOps approach in building production ready CI/CD pipeline,the tools we are going to use are listed below: </li>
   <ol>
     <li>Python</li>
      <li>Github: as a single source of truth</li>
      <li>Docker:</li>
     <ol>
       <li>Build the flask image</li>
     </ol>
      <li>Docker hub:</li>
     <ol>
       <li>To push the docker flask image as an artifact</li>
       <li>To pull the docker flask image from the artifact</li>
     </ol>
      <li>Jenkins: Jenkins is the heart of the entire CI/CD pipeline where we are going to:</li>
     <ol>
       <li>Build the image from Dockerfile.</li>
        <li>Push the image to the Docker-hub</li>
        <li>Declare our environment credentials for Jenkins to interact with the docker hub</li>
        <li>Perform a SVM checkout</li>
        <li>Build the project</li>
			 <li>Deploy the Kubernetes cluster using terraform</li>
     </ol>
      <li>Terraform: We are going to use terraform to provision the Kubernetes cluster</li>
		 <ol>
			 <li>Using a Kubernetes.tf  file we are going to set details of our deployment and service.</li>
			 <li>The docker hub repository and the flask application name that we are going to provision into our cluster</li>
			 <li>The number of repilicas of 3 flask app.</li>
			 <li>Terraform doesn't only create resources, it updates, and deletes tracked resources without requiring to inspect the API to identify those resource.</li>
					 </ol>
      <li>AWS: using AWS we are leveraging the cloud features:</li>
		 <ol>
			 <li>Creating EC-2 instances of our linux environments.</li>
			 <li>AWS instances will provide the complete environment to run our CI/CD pipeline.</li>
			 <li>Mobaxterm and PUTTY: using this tool we can ssh into our ec2 instances and    work into them.</li>
		 </ol>
		 <li>Virtual Box: using ubuntu 20.04 virtual box to run our entire end-to-end tool stack having our Jenkins pipline to integrate the build and deploy.</li>
		 <li>ELK (Elastic-Logstash-Kibana stack) : Setting and configuring the ELK stack to monitor our CPU, memory, Disk utilization along with our flask app.</li>
     <li>Prometheus and Grafana : Setting and configuring the two, to monitor our CPU, memory, Disk utilization along with our flask app.</li>
		 <li>Network monitoring tool: using htop to show the system utilizing and to compare with the ELK dashboard.</li>
		 <li>Stress tool: using the stress tool to induce load on the system and to monitor the changes we need to be alerted if the system exceeds 80% of utilization.</li>
   </ol>
</ol>
</h3>
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/toolstack.png">
<h2>Flow Chart:</h2>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/cicdmain.png">

<h2>Setting up the environment: </h2>
<h3>Set up a virtualBox with ubuntu 20.04 iso image, keeping in mind that we
 need GUI utility for launching the Jenkins server and the ELK dashboard.
Installed the required tool stack: docker, docker-compose, jenkins, terraform, kubectl, kind, terraform and ELK stack. At the jenkins we install all the needed plugins.</h3>

<h2>Implementing the pipeline:</h2>
<ol>
	<li> Create a new jenkin's pipeline and configuring the job with needed plugins, configuring the global tools and setting the credentials and evironnment variable for docker hub repo and terraform file. </li>
<li> Our pipeline will clean the workspace and checkout the source code from git.Then we use the environment settings to build and push the image to docker hub vijaya81kp/tfflaskapp</li> 
<li>  We use terraform to use the above mentioned image from the docker hub and using the kubernetes.tf we trigger the terraform init and terraform apply to provision our kubernetes cluster with the flask application.</li> 
	</ol>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/jenkinsbuild.png">
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/jenkinsbuildview.png">

<h2>Deployment of the flask app into the kind cluster:</h2>
<h3>The flask app is now successfully deployed into our kubernetes cluster as shown below:</h3>

<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/Deployment1.png">

<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/deployment2.png">

<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/deployment3.png">

<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/deployment4.png">

<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/deployment5.png">

<h2>Monitoring</h2>
<h3>Elastic,Logstash and kibana are products most commonly used together for log analysis in different IT environments. Using  ELK Stack we can perform centralized logging which helps in identifying the problems with the web servers or applications. It lets you search through all the logs at a single place and identify the issues spanning through multiple servers by correlating their logs within a specific time frame.</h3>
<ol>
<li>Logstash is the data collection pipeline tool. It the first component of ELK Stack which collects data inputs and feeds it to the Elasticsearch. It collects various types of data from different sources, all at once and makes it available immediately for further use.</li>
<li>Elasticsearch is a NoSQL database which is based on Lucene search engine and is built with RESTful APIs. It is a highly flexible and distributed search and analytics engine. Also, it provides simple deployment, maximum reliability, and easy management through horizontal scalability. It provides advanced queries to perform detailed analysis and stores all the data centrally for quick search of the documents. </li>
<li>Kibana is a data visualization tool. It is used for visualizing the Elasticsearch documents and helps the us to have an immediate insight into it. Kibana dashboard provides various interactive diagrams,data, timelines, and graphs to visualize the complex queries done using Elasticsearch. Using Kibana we can create and save custom graphs according to our specific needs</li>
</ol>
<h3>Monitoring our flask app without and with load ELK</h3>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor1.png">
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor2.png">
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor3.png">

<h3>Introducing the stress</h3>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor4.png">
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor5.png">

<h3>Maximum stress and message</h3>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor6.png">
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor7.png">

<h3>monitoring high stress with htop</h3>
<img src="https://github.com/srinanpravij/terraform-flask/blob/main/images/monitor8.png">

<h3>Monitoring our flask app using Prometheus and Grafana:</h3>
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
<img src="https://github.com/srinanpravij/capterraform/blob/master/images/grafana1.png">
	
