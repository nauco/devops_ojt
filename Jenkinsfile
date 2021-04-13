node {
     try{
          stage('Clone repository') {
              checkout scm
          }
          stage('Initialize'){
             def dockerHome = tool 'myDocker'
             env.PATH = "${dockerHome}/bin:${env.PATH}"
         }
          stage('Build image') {
             app = docker.build("sample-ecr", "--network=host .") 
             sh("docker images")
             //sh("docker run --rm -v ~/.aws:/root/.aws amazon/aws-cli eks --region ap-northeast-2 update-kubeconfig --name example")  
             sh("docker run --rm -v ~/.aws:/root/.aws amazon/aws-cli sts get-caller-identity")
             //sh("docker run --rm -v ~/.aws:/root/.aws amazon/aws-cli ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/")
          }
          stage('Push image') {
             //sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
             //sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
             withAWS(credentials: 'ecr-credit', region: 'ap-northeast-2') {
                  sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
                  sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
             }
         }
          
          slackSend (channel: '#project', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
     }
     catch (e) {
          slackSend (channel: '#project', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          
     }
     /*stage('Push image') {
         //sh 'rm  ~/.dockercfg || true'
         //sh 'rm ~/.docker/config.json || true'
         
          docker.withRegistry("https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com", "ecr:ap-northeast-2:sample-ecr") {
            //sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
            //sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
             app.push("${env.BUILD_NUMBER}")
             //app.push("latest")
          }
          
     }*/
     

}
