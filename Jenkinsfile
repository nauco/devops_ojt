node {
     stage('Start') {
            steps {
                slackSend (channel: '#project', color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }
     stage('Clone repository') {
         checkout scm
     }
     stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
     stage('Build image') {
         app = docker.build("sample-ecr")  
     }

     stage('Push image') {
         sh 'rm  ~/.dockercfg || true'
         sh 'rm ~/.docker/config.json || true'
         
         docker.withRegistry('https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:ecr-credit') {
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
     }
  }
         post {
        success {
            slackSend (channel: '#project', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend (channel: '#project', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}
