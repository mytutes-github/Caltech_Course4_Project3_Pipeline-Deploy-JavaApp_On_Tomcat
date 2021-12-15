currentBuild.displayName = "Course4Project3_CI-CD-Workflow_#"+currentBuild.number

node {
    
    def mvnHome = tool name: 'Apache_Maven_3.5.3', type: 'maven'    
    def mvnCMD = "${mvnHome}/bin/mvn"
    
    
    stage('Clean Up') {

        deleteDir()
    }   
    
    
    stage('Git Checkout') {
 
        git credentialsId: 'SSH_Git-Jenkins', url: 'git@github.com:mytutes-github/Caltech_Course4_Project3_Pipeline-Deploy-JavaApp_On_Tomcat.git'

    }

    stage('Maven Package') {
          
        sh "${mvnCMD} clean package"
        
    }


    stage('Maven Test') {
          
        sh "${mvnCMD} test"
        
    }
    
    stage('Tomcat Dependencies') {
 
    sh '''echo  "mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2"  >>  script.sh
          echo  "mv /usr/local/tomcat/webapps.dist/ /usr/local/tomcat/webapps"  >>  script.sh
          echo  "mv /usr/local/tomcat/webapps2/* /usr/local/tomcat/webapps"  >>  script.sh'''

    }
    
    stage('Build Docker Image'){

    sh 'docker build -t mydevopslabs/my-app:0.0.1 .'

  }

  stage('Upload Image to DockerHub'){

    withCredentials([string(credentialsId: 'DockerHubAccessToken', variable: 'DockerHubAccessToken')]) {
    
    sh "docker login -u mydevopslabs -p ${DockerHubAccessToken}"
    
    }

    sh 'docker push mydevopslabs/my-app:0.0.1'
  }

  stage('Deploy Docker Container'){

      sh 'docker run -d -p 8081:4287 --name my-app mydevopslabs/my-app:0.0.1'

    }
  
}