node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
     stage('Build image') {
        app = docker.build("sample-ecr", "--build-arg --network=host") 
     }

     stage('Push image') {
         sh 'rm  ~/.dockercfg || true'
         sh 'rm ~/.docker/config.json || true'
         
         docker.withRegistry('https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:ecr-credit') {
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
     }
  }
}
