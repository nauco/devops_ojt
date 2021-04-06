node {
     stage('Clone repository') {
         checkout scm
     }

     stage('Build image') {
         app = docker.build("public.ecr.aws/b0n8t3d2/sample-ecr")
     }

     stage('Push image') {
         sh 'rm  ~/.dockercfg || true'
         sh 'rm ~/.docker/config.json || true'
         
         docker.withRegistry('public.ecr.aws/b0n8t3d2/sample-ecr', 'ecr:ap-northeast-2:ecr-credit') {
             app.push("latest")
     }
  }
}
