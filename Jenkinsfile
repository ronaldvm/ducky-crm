
pipeline {
  agent none
  stages {
    
      stage('Build') {
        agent { label 'maven-app' }
        steps {
          container('maven') {
            sh 'mvn clean package'
            sh 'ls'
            stash includes: 'target/*', name: 'builtSources'
          }
        }
      }

      stage('Test') {
        agent { label 'detect-app' }
        when {
          expression {
            currentBuild.result == null || currentBuild.result == 'SUCCESS' 
          }
        }
        steps {
          container('detect') {
            sh 'wget https://detect.synopsys.com/detect.sh'
            sh 'ls'
            sh 'chmod +x detect.sh'
            sh './detect.sh \
                --blackduck.url="https://bizdevhub.blackducksoftware.com" \
                --blackduck.api.token="MDVlYWEyODQtMzc5NS00NzVkLWJhN2MtN2M4YWY3ZmUwMjJiOjRmNjc0OWEyLWFiZjUtNDgwNS05ZjBjLTllNzJmNjVmYmNhNQ==" \
                --detect.project.name="CloudBeesDucky" \
                --detect.project.name="CloudBeesDucky" \
                --detect.project.version.name="${BUILD_TAG}" \
                --detect.risk.report.pdf=true \
                --blackduck.trust.cert=true \
                --detect.api.timeout=900000'
          }
        }
      }
    
  }
}
