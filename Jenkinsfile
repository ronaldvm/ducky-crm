
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
                --blackduck.api.token="$BLACKDUCK_ACCESS_TOKEN" \
                --blackduck.trust.cert=true \
                --detect.project.name="CloudBeesDucky" \
                --detect.tools="DETECTOR,POLARIS" \
                --detect.project.version.name="DETECTOR_${BUILD_TAG}" \
                --detect.risk.report.pdf=true
                --detect.polaris.enabled=true \
                --polaris.url="https://sipse.polaris.synopsys.com" \
                --polaris.access.token="$POLARIS_ACCESS_PASSWORD" '
            sh 'find  . -type f -iname "*.pdf" -exec tar -rvf out.tar {} \;'
            archiveArtifacts artifacts: '**/*.tar', fingerprint: true, onlyIfSuccessful: true
          }
        }
      }

  }
}
