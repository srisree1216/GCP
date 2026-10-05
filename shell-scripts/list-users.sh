#!/bin/bash

########################################
# List github repo users(collabrators) using shell script and github api
# #Author : Sirisa
# Date : 5th October
# ######################################


API_URL="https://api.github.com"

# GitHub username and personal access token
Username=$username
Token=$token

echo $API_URL

echo $Username
echo $Token

# User and Repository information
Repo_Owner=$1

Repo_name=$2

echo $Repo_Owner,$Repo_name

# Function to make a GET request to the GitHub API

function github_api_get {
        local endpoint=$1
        echo endpoint
        local url="${API_URL}/${endpoint}"

        echo $url

        #gthub authentication using curl

        curl -s -u "${Username}:${Token}" "$url"
}


function list_users_with_read_access {
         local endpoint="repos/${Repo_Owner}/${Repo_name}/collaborators"

         echo $endpoint

         collabs="$(github_api_get "$endpoint" | jq -r '.[]| select(.permissions.pull==true)|.login')"

  if [[ -z "$collabs" ]]; then
        echo "No users with read access found for ${Repo_Owner}/${Repo_name}."
    else
        echo "Users with read access to ${Repo_Owner}/${Repo_name}:"
        echo "$collabs"
    fi
}


echo "Listing users with read access to ${Repo_Owner}/${Repo_name}..."
list_users_with_read_access
