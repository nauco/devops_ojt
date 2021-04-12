node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
     stage('Build image') {
        app = docker.build("191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr", "--network=host .") 
     }

     stage('Push image') {
         sh 'rm  ~/.dockercfg || true'
         sh 'rm ~/.docker/config.json || true'
         
         docker.withRegistry('https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com', 'ecr:ap-northeast-2:sample-ecr') {
             def customImage = docker.build("${env.BUILD_NUMBER}")
             customImage.push()
     }
  }
}
