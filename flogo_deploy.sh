#! /bin/bash

echo Deploying Flogo App $(appName)

result=$(curl -s -o /dev/null -w '%{http_code}' -X 'POST' '$(tciBaseUrl)/apps?appName=$(appName)&instanceCount=$(instanceCount)'
                   -H 'accept: application/json' 
                   -H 'Authorization: Bearer $(TibcoTCIToken)' 
                   -H 'Content-Type: multipart/form-data' 
                   -F 'artifact=@flogo.json;type=application/json' 
                   -F 'manifest.json=@manifest.json;type=application/json') 
				   
echo status code: $result

if [ $result -eq 202 ] 
then
  echo Deployment succesvol
else
  echo $result
  exit 1
fi