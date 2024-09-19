#!/bin/bash


# Set the search string
search_string="bpsd"

# Get the list of all secrets
secrets_list=$(aws secretsmanager list-secrets --query "SecretList[*].Name" --output text)

# Loop through each secret and check if it contains the search string
for secret in $secrets_list; do
  if [[ $secret == *$search_string* ]]; then
    echo "Deleting secret: $secret"
    aws secretsmanager delete-secret --secret-id "$secret" --force-delete-without-recovery
  fi
done

echo "FIN"
