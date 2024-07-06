#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <name-of-text-file>"
  exit 1
fi

INPUT_FILE=$1
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.csv"

# Create log and password files with proper permissions
touch $LOG_FILE
chmod 644 $LOG_FILE

mkdir -p /var/secure
touch $PASSWORD_FILE
chmod 600 $PASSWORD_FILE

# Function to generate a random password
generate_password() {
  echo $(openssl rand -base64 12)
}

# Read the input file line by line
while IFS=';' read -r username groups; do
  username=$(echo $username | xargs) # Remove leading/trailing whitespace
  groups=$(echo $groups | xargs) # Remove leading/trailing whitespace

  # Check if the user already exists
  if id -u $username >/dev/null 2>&1; then
    echo "User $username already exists. Skipping." | tee -a $LOG_FILE
    continue
  fi

  # Create the user and their personal group
  useradd -m -s /bin/bash -G $username $username
  if [ $? -eq 0 ]; then
    echo "User $username created successfully." | tee -a $LOG_FILE
  else
    echo "Failed to create user $username." | tee -a $LOG_FILE
    continue
  fi

  # Assign user to additional groups
  IFS=',' read -ra ADDR <<< "$groups"
  for group in "${ADDR[@]}"; do
    group=$(echo $group | xargs) # Remove leading/trailing whitespace

    # Check if the group exists, if not, create it
    if ! getent group $group >/dev/null 2>&1; then
      groupadd $group
      if [ $? -eq 0 ]; then
        echo "Group $group created successfully." | tee -a $LOG_FILE
      else
        echo "Failed to create group $group." | tee -a $LOG_FILE
        continue
      fi
    fi

    usermod -aG $group $username
    if [ $? -eq 0 ]; then
      echo "User $username added to group $group." | tee -a $LOG_FILE
    else
      echo "Failed to add user $username to group $group." | tee -a $LOG_FILE
    fi
  done

  # Generate a random password for the user
  password=$(generate_password)
  echo $username:$password | chpasswd
  echo "$username,$password" >> $PASSWORD_FILE

done < "$INPUT_FILE"

echo "User creation process completed. Check $LOG_FILE for details."
