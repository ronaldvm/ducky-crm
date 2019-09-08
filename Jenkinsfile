
pipeline {
  agent none
  stages {

      stage('Build + Detector + Static Scan') {
        agent { label 'maven-app' }
        when {
          expression {
            currentBuild.result == null || currentBuild.result == 'SUCCESS'
          }
        }
        steps {
          container('maven-with-wget') {
            sh 'mvn clean package'
            sh 'wget https://detect.synopsys.com/detect.sh'
            sh 'chmod +x detect.sh'
            sh './detect.sh \
                --blackduck.url="https://bizdevhub.blackducksoftware.com" \
                --blackduck.api.token="MDVlYWEyODQtMzc5NS00NzVkLWJhN2MtN2M4YWY3ZmUwMjJiOjRmNjc0OWEyLWFiZjUtNDgwNS05ZjBjLTllNzJmNjVmYmNhNQ==" \
                --blackduck.trust.cert=true \
                --detect.project.name="CloudBeesDucky" \
                --detect.tools="DETECTOR" \
                --detect.project.version.name="Detector_${BUILD_TAG}" \
                --detect.risk.report.pdf=true'
            
            sh './detect.sh \
                --detect.polaris.enabled="true" \
                --detect.tools="POLARIS" \
                --polaris.url="https://sipse.polaris.synopsys.com" \
                --polaris.access.token="nresfs58d55nb3d7c8s52luj2a2iciiiicnielsdae3uesi95850" '
            
             archiveArtifacts artifacts: '**/*.pdf', fingerprint: true, onlyIfSuccessful: true
          }
        }
      }

  }
}
