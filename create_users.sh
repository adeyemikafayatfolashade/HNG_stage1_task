#!/bin/bash

# Log file and password file paths
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Create log and password files
sudo touch $LOG_FILE
sudo touch $PASSWORD_FILE

# Set permissions for the password file
sudo chmod 600 $PASSWORD_FILE

# Function to log actions
log_action() {
    local action=$1
    echo "$(date): $action" | sudo tee -a $LOG_FILE
}

# Function to generate random password
generate_password() {
    local password=$(openssl rand -base64 12)
    echo $password
}

# Read input file
while IFS=';' read -r username groups; do
    # Ignore whitespace
    username=$(echo "$username" | xargs)
    groups=$(echo "$groups" | xargs)
    
    if id "$username" &>/dev/null; then
        log_action "User $username already exists."
    else
        # Create user and personal group
        sudo useradd -m -s /bin/bash "$username"
        log_action "Created user $username with home directory and personal group."

        # Generate and set password
        password=$(generate_password)
        echo "$username:$password" | sudo chpasswd
        log_action "Set password for user $username."
        echo "$username,$password" | sudo tee -a $PASSWORD_FILE

        # Add user to specified groups
        IFS=',' read -ra group_array <<< "$groups"
        for group in "${group_array[@]}"; do
            group=$(echo "$group" | xargs)
            if ! getent group "$group" &>/dev/null; then
                sudo groupadd "$group"
                log_action "Created group $group."
            fi
            sudo usermod -aG "$group" "$username"
            log_action "Added user $username to group $group."
        done
    fi
done < "$1"

log_action "User creation script completed."
