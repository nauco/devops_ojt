node {
     stage('Pull') {
            git 'https://github.com/JUNGEEYOU/jenkins_flask.git'
      }
      stage('Build') {
            sh(script: 'docker build -t app . ')
      }    
}
