#!/bin/bash
API_BASE_URL="54.237.202.219"
touch response.txt
response=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE_URL/)
RESPONSES+=("$response")
id=$(curl -s $API_BASE_URL/id-for-test)

if [[ $response == *"200"* ]]; then
  echo "GET Request to / was successful." >> response.txt
else
  echo "GET Request to / failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X GET -H "Content-Type: application/x-www-form-urlencoded"  $API_BASE_URL/subscriptions)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "GET Request to /subscriptions was successful." >> response.txt
else
  echo "GET Request to /subscriptions failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X GET -H "Content-Type: application/x-www-form-urlencoded"  $API_BASE_URL/subscriptions_ids)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "GET Request to /subscriptions_ids was successful." >> response.txt
else
  echo "GET Request to /subscriptions_ids failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "training_program=AB"  $API_BASE_URL/subscriptions_by_training_program)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "POST Request to /subscriptions_by_training_program was successful." >> response.txt
else
  echo "POST Request to /subscriptions_by_training_program failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "id=$id" $API_BASE_URL/subscription_by_id)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "POST Request to /subscription_by_id was successful." >> response.txt
else
  echo "POST Request to /subscription_by_id failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "first_name=first_name&last_name=last_name&birth_date=birth_date&training_program=AB&weight=70&height=174"  $API_BASE_URL/add_subscription)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "POST Request to /add_subscription was successful." >> response.txt
else
  echo "POST Request to /add_subscription failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "id=$id&first_name=first_name&last_name=last_name&birth_date=birth_date&training_program=AB&weight=73&height=174" $API_BASE_URL/update_subscription)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "POST Request to /update_subscription was successful." >> response.txt
else
  echo "POST Request to /update_subscription failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "id=$id"  $API_BASE_URL/subscription_BMI)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
   echo "POST Request to /subscription_BMI was successful." >> response.txt
else
   echo "POST Request to /subscription_BMI failed." >> response.txt
fi

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/x-www-form-urlencoded" --data "id=$id"  $API_BASE_URL/delete_subscription)
RESPONSES+=("$response")
if [[ $response == *"200"* ]]; then
  echo "DELETE Request to /subscription was successful." >> response.txt
else
  echo "DELETE Request to /subscription failed." >> response.txt
fi

for item in "${RESPONSES[@]}"; do
  if [[ $item == 200 ]]; then
    continue
  else
    echo "Test Failed"
    exit 1
  fi
done