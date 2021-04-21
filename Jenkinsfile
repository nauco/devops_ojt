node {
     try{
          stage('Slack notify') {
               slackSend (channel: '#project', color: 'good', message: "Start Pipeline: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          }
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
          }
          stage('Clone and Push manifest') {
               def gitValues = git branch: 'main', credentialsId: '5765a451-0e4b-4558-b996-9c4e77e9fe70', url:'git@github.com:nauco/ops.git'
               sh('cat deployment.yaml')
               def filename = 'deployment.yaml'
               def data = readYaml file: filename

               // Change something in the file
               sh "echo ${data.spec.template.spec.containers[0].image}"

               //def pattern = ~/:(\d+)$/
               //def newV = v.replaceFirst(pattern) { _, patch ->":${(patch as Integer) + 1}" }
               
               data.spec.template.spec.containers[0].image = "191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}"
               sh "rm $filename"
               writeYaml file: filename, data: data
               sh('cat deployment.yaml')
               sh('git config --global user.email "hodong42@gmail.com"') 
               sh('git config --global user.name "hodong"')
               sh('git add .')
               sh('git commit -m "commit test"')
               sshagent(['5765a451-0e4b-4558-b996-9c4e77e9fe70']) {
                    sh "git push origin main"
               }
          }
          slackSend (channel: '#project', color: 'good', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
     }
     catch (e) {
          slackSend (channel: '#project', color: 'danger', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")    
     }
}
