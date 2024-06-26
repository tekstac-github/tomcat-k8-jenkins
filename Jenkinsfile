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
	
	stage('deployment'){
		steps{
		//deploy adapters: [tomcat9(credentialsId: 'TomcatCreds' path: '', url: 'http://locahost:8100/')], contextPath: 'counterwebapp', war: 'target/*.war'
		deploy adapters: [tomcat9(url: 'http://localhost:8100/', 
                              credentialsId: 'tomcat-credentials')], 
                     war: 'target/*.war',
                     contextPath: 'app'
		}
		
	}
	
}
}
