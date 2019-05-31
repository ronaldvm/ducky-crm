workflow "Build and Container Scan" {
  on = "push"
  resolves = "Synopsys Detect"
}

action "Build Maven" {
  uses = "./maven-cli"
  args = ["clean package"]
}

action "Build Container" {
  needs = ["Build Maven"]
  uses = "actions/docker/cli@master"
  args = "build -t $GITHUB_REPOSITORY ."
}

action "Export to Tar" {
  needs = ["Build Container"]
  uses = "actions/docker/cli@master"
  args = "export $GITHUB_REPOSITORY > CONTAINER_NAME.tar"
}

action "Synopsys Detect" {
  needs = ["Export to Tar"]
  uses = "gautambaghel/synopsys-detect@master"
  secrets = ["BLACKDUCK_URL","BLACKDUCK_API_TOKEN","SWIP_ACCESS_TOKEN", "SWIP_SERVER_URL"]
  args = "--detect.tools=DOCKER --detect.project.name=ACTION_CONTAINER_SCAN --detect.docker.image=$GITHUB_REPOSITORY"
}
