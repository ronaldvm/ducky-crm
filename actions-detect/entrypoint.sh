#!/bin/bash
bash <(curl -s https://detect.synopsys.com/detect.sh) \
--blackduck.url="https://bizdevhub.blackducksoftware.com" \
--blackduck.api.token="NWU3NzM4MzQtMWU3Yi00MjVkLThkZTMtNTVlNzQyY2Q0ODFkOjdkOWM5NGJiLTRhZDUtNDk3Yy04NDdlLWMyNmFmMDBkYTg4ZA==" \
--detect.project.name="JenkinsDucky" \
--detect.policy.check.fail.on.severities=ALL \
--detect.risk.report.pdf=true \
--blackduck.trust.cert=true \
--detect.api.timeout=900000
