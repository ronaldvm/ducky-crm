
pipeline {
  agent none
  stages {

      stage('Build') {
        agent { label 'maven-app' }
        steps {
          container('maven') {
            sh 'mvn clean package'
            stash includes: 'target/*', name: 'builtSources'
          }
        }
      }

      stage('Detect') {
        agent { label 'detect-app' }
        when {
          expression {
            currentBuild.result == null || currentBuild.result == 'SUCCESS'
          }
        }
        steps {
          container('detect') {
            unstash 'builtSources'
            sh 'bash <(curl -s https://detect.synopsys.com/detect.sh) \
                --blackduck.url="https://bizdevhub.blackducksoftware.com" \
                --blackduck.api.token="MDVlYWEyODQtMzc5NS00NzVkLWJhN2MtN2M4YWY3ZmUwMjJiOjRmNjc0OWEyLWFiZjUtNDgwNS05ZjBjLTllNzJmNjVmYmNhNQ==" \
                --detect.project.name="CloudBeesDucky" \
                --detect.tools="SIGNATURE_SCAN" \
                --detect.project.version.name="${BUILD_TAG}" \
                --detect.risk.report.pdf=true \
                --detect.report.timeout=9000 \
                --blackduck.trust.cert=true' 
            archiveArtifacts artifacts: '**/*.pdf', fingerprint: true, onlyIfSuccessful: true
          }
        }
      }

  }
}
