node {
     stage('Clone repository') {
         checkout scm
     }

     stage('Push image') {
         sh 'rm  ~/.dockercfg || true'
         sh 'rm ~/.docker/config.json || true'
         
         docker.withRegistry('https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:ecr-credit') {
             app = docker.build("191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr")
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
     }
  }
}
