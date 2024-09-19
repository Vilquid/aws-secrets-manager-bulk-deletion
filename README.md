
# AWS Secrets Manager bulk deletion

This bash script automates the process of deleting multiple AWS Secrets Manager secrets that contain a specific search string in their names.

## Description

The script performs the following actions:

1. Set the search string: Defines the specific string to search for within secret names.
2. List all secrets: Retrieves a list of all secret names from AWS Secrets Manager.
3. Filter secrets: Identifies secrets that contain the search string.
4. Delete secrets: Deletes the matched secrets without recovery.
5. Completion message: Prints a "FIN" message upon completion.

## Prerequisites

- AWS CLI : Ensure that the AWS Command Line Interface is installed and configured with the necessary permissions.
- AWS credentials : The AWS user must have permissions to list and delete secrets in AWS Secrets Manager.
- Bash shell: This script is intended to run in a Unix-like environment.

## Usage

```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
chmod +x nuke_secrets.sh
# Set the search string in the script :
# search_string="your-search-string"
./nuke_secrets.sh
```

Note: You may need to run the script with sudo privileges depending on your environment.

## How it works

1. Set the search string :
    ```bash
    search_string="bpsd"
    ```
    Replace "bpsd" with the string you want to search for in the secret names.

2. List all secrets :
    ```bash
    secrets_list=$(aws secretsmanager list-secrets --query "SecretList[*].Name" --output text)
    ```
    Retrieves all secret names from AWS Secrets Manager.

3. Filter and delete secrets :
    ```bash
    for secret in $secrets_list; do
      if [[ $secret == *$search_string* ]]; then
        echo "Deleting secret: $secret"
        aws secretsmanager delete-secret --secret-id "$secret" --force-delete-without-recovery
      fi
    done
    ```
    Loops through each secret and deletes those that contain the search string.

4. Completion message:
    ```bash
    echo "FIN"
    ```
    Indicates that the script has finished executing.

## Important notes

- Irreversible deletion : The script uses the `--force-delete-without-recovery option`, which permanently deletes the secrets without any recovery window. Use with caution.
- Permissions : Ensure that your AWS credentials have the necessary permissions to list and delete secrets.
- Testing : It's recommended to test the script with a non-critical search string to verify functionality before running in a production environment.
- Logging : You may want to redirect the output to a log file for auditing purposes.

## Disclaimer
Use this script responsibly and at your own risk. Deleting secrets is an irreversible action that can impact applications relying on them. Always ensure you have backups or have documented the secrets before deletion. The author is not responsible for any loss or damage resulting from the use of this script.
