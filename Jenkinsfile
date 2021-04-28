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
               sh('docker images')
               sh('docker build sample-ecr --network=host .')
          }
          stage('Push image') {
               ecr_push()
          }
          stage('Clone and Push manifest') {
               //git Clone
               def gitValues = git branch: 'main', credentialsId: '5765a451-0e4b-4558-b996-9c4e77e9fe70', url:'git@github.com:nauco/ops.git'
               modify_manifest()
               git_push()
          }
          stage('Trigger Argocd and Deploy') {
               deploy_app()
          }
     }
     catch (e) {
     }
}

def ecr_push() {
     withAWS(credentials: 'ecr-credit', region: 'ap-northeast-2') {
          def login = ecrLogin()
          sh "${login}"
          sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}")
          sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}")
     }
}

def modify_manifest() {
     def filename = 'deployment.yaml'
     def data = readYaml file: filename
     data.spec.template.spec.containers[0].image = "191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:${env.BUILD_NUMBER}"
     sh "rm $filename"
     writeYaml file: filename, data: data
}

def git_push() {
     sh('git config --global user.email "hodong42@gmail.com"') 
     sh('git config --global user.name "hodong"')
     sh('git add .')
     sh('git commit -m "update image"')
     sshagent(['5765a451-0e4b-4558-b996-9c4e77e9fe70']) {
          sh "git push origin main"
     }
}

def deploy_app() {
     sh('curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.0.1/argocd-linux-amd64')
     sh('chmod +x /usr/local/bin/argocd')
     withCredentials([string(credentialsId: "argo-pw", variable: 'ARGOCD_PASSWORD')]) {
          sh('argocd login 10.100.200.201:80 --username admin --password=$ARGOCD_PASSWORD --grpc-web --insecure')
          sh '''
          if argocd app list -o name | grep -x 'flask' ; then
              echo 'already exist'
          else
              argocd app create flask --repo https://github.com/nauco/ops.git --path ./ --dest-namespace default --dest-server https://kubernetes.default.svc --sync-policy auto
              argocd app patch flask --patch '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-succeeded.slack":"project"}}}' --type merge
          fi
          '''
     }
}
