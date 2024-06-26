pipeline {
	agent any
	
	stages{
		stage('Checkout Code'){
			steps{
				checkout scm
				}
			}
	
	stage('Build'){
		steps{
			sh ''' #!/bin/bash
					/opt/maven/bin/mvn clean install -Dmaven.test.skip=true
			'''
		}
	}
	
	stage('Archive Artifact'){
		steps{
		archiveArtifacts artifacts:'target/*.war'
		}
	}
	
	    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("jenkinsci-cd/webserver")
    }

    stage('Test image') {
	steps{
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
	}
    }

    stage('Push image') {
        steps{
	    /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://localhost:5000', 'docker-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
	}
    }
    stage('Run Docker Container'){
       steps{
	    /* Running the image on production Environment */
      sh label: '', script: 'docker run -d -p 80:80 localhost:5000/jenkinsci-cd/webserver &' 
  }
    }
}
}
