#!/bin/bash

# Realizamos la petición con curl y guardamos la respuesta
response=$(curl --silent --location 'https://xray.cloud.getxray.app/api/v2/authenticate' \
--header 'Content-Type: application/json' \
--data '{"client_id":"F962712CB55746DEADA15F542EB23F68",
  "client_secret":"957bb1d70dfef9d0bc9bc4ea6f2b0fa7333fa6d6baf3af88a4b10eee54ff0132"}'
)

# Extraemos el valor del token de la respuesta
token=$(echo $response | jq -r '')

# Imprimimos el token
echo $token

# Reemplaza esto con la URL de tu endpoint GraphQL
url='https://xray.cloud.getxray.app/api/v2/graphql'

# La consulta GraphQL
# Define la consulta GraphQL
query='{
    "query": "{ getTestPlans(jql: \"project = 'PX'\", limit: 10) { results { issueId jira(fields: [\"summary\", \"customfield_10037\", \"customfield_10106\", \"customfield_10107\", \"customfield_10108\"])
        }
    }
}"
}'

# Realizamos la petición con curl y guardamos la respuesta
response1=$(curl --silent -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$query" $url)

# Imprime la respuesta
issueIds1=$(echo $response1 | jq -r '.data.getTestPlan.jira.customfield_10037')
issueIds2=$(echo $response1 | jq -r '.data.getTestPlan.jira.customfield_10106')
issueIds3=$(echo $response1 | jq -r '.data.getTestPlan.jira.customfield_10107')
issueIds4=$(echo $response1 | jq -r '.data.getTestPlan.jira.customfield_10108')
echo $issueIds1
echo $issueIds2
echo $issueIds3
echo $issueIds4

