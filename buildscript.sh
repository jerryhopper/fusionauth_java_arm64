#!/bin/bash


docker build https://github.com/jerryhopper/fusionauth_java_arm64.git -t fusionauth-java-arm64:latest
docker tag fusionauth-java-arm64:latest jerryhopper/fusionauth-java-arm64:latest
docker push jerryhopper/fusionauth-java-arm64:latest
