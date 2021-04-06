node {
     stage('Pull') {
            git 'https://github.com/nauco/devops_ojt.git'
      }
      stage('Build') {
            sh(script: 'docker build -t app . ')
      }    
}
