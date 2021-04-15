node {
     try{
          stage('Clone repository') {
              checkout scm
          }
          stage('Initialize'){
             def dockerHome = tool 'myDocker'
             env.PATH = "${dockerHome}/bin:${env.PATH}"
         }
          /*stage('Build image') {
             app = docker.build("sample-ecr", "--network=host .") 
             sh("docker images")
             //sh("docker run --rm -v ~/.aws:/root/.aws amazon/aws-cli ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/")
          }
          stage('Push image') {
             withAWS(credentials: 'ecr-credit', region: 'ap-northeast-2') {
                  script {
                        def login = ecrLogin()
                        sh "${login}"
                        sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}")
                        sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}")
                   }
             }
          }*/
          stage('Git Push') {
               sh("git clone https://github.com/nauco/opts")
               sh("git config --list")
          }
          
          slackSend (channel: '#project', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
     }
     catch (e) {
          slackSend (channel: '#project', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")    
     }
}
