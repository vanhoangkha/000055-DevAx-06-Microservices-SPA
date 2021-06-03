#!/bin/bash
arr[0]="Melbourne"
arr[1]="Perth"
arr[2]="Sydney"
arr[3]="Brisbane"
arr[4]="Darwin"
arr[5]="Hobart"
arr[6]="Canberra"
arr[7]="Newcastle"
arr[8]="London"
arr[9]="Dallas"
arr[10]="Cairo"
arr[11]="LA"
arr[12]="Singapore"
arr[13]="Broome"
arr[14]="Dubbo"
arr[15]="Geelong"

echo Adding 50 trips to DDB table...

for ((n=1;n<=50;))
do    
    randomOrigin=$[$RANDOM % 16]
    randomDestination=$[$RANDOM % 16]
    if [ $randomOrigin != $randomDestination ]; then    
        echo $n Adding ${arr[$randomOrigin]} to ${arr[$randomDestination]}
        randomDate=$(($(($(date "+%s") + $((($RANDOM)*1000)))) * 1000))
        aws dynamodb put-item --region $1 --table-name TravelBuddyTripSectors --item "{\"date\": {\"N\": \"$randomDate\"},\"originCity\": {\"S\": \"${arr[$randomOrigin]}\"},\"destinationCity\": {\"S\": \"${arr[$randomDestination]}\"},\"airline\": {\"S\": \"Qantas\"}}";
        ((++n))
    fi
done

echo Adding in Melbourne as origin to ensure test succeeds
randomDate=$(($(($(date "+%s") + $((($RANDOM)*1000)))) * 1000))
aws dynamodb put-item --region $1 --table-name TravelBuddyTripSectors --item "{\"date\": {\"N\": \"$randomDate\"},\"originCity\": {\"S\": \"Melbourne\"},\"destinationCity\": {\"S\": \"Sydney\"},\"airline\": {\"S\": \"Qantas\"}}";

echo Adding in Melbourne as destination to ensure test succeeds
randomDate=$(($(($(date "+%s") + $((($RANDOM)*1000)))) * 1000))
aws dynamodb put-item --region $1 --table-name TravelBuddyTripSectors --item "{\"date\": {\"N\": \"$randomDate\"},\"originCity\": {\"S\": \"Sydney\"},\"destinationCity\": {\"S\": \"Melbourne\"},\"airline\": {\"S\": \"Qantas\"}}";
