node {
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
        sh("alias aws='docker run --rm -v ~/.aws:/root/.aws amazon/aws-cli'")
        sh("aws sts get-caller-identity")
     }

     stage('Push image') {
         //sh 'rm  ~/.dockercfg || true'
         //sh 'rm ~/.docker/config.json || true'
         
          docker.withRegistry("https://191845259489.dkr.ecr.ap-northeast-2.amazonaws.com", "ecr:ap-northeast-2:sample-ecr") {
            sh("docker tag sample-ecr:latest 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
            sh("docker push 191845259489.dkr.ecr.ap-northeast-2.amazonaws.com/sample-ecr:latest")
             //app.push("${env.BUILD_NUMBER}")
             //app.push("latest")
          }
          
     }
}
