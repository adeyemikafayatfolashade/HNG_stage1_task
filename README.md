# Linux User Creation Bash Script

## Overview

This project contains a bash script called create_users.sh that automates the creation of users and groups based on an input text file. The script sets up home directories, assigns users to groups, generates random passwords, logs all actions, and securely stores passwords.

## Task Requirements

- **Create users and groups**: Users and their groups are created as specified in the input file.
- **Set up home directories**: Home directories are created with appropriate permissions.
- **Generate random passwords**: Random passwords are generated and securely stored.
- **Log actions**: All actions are logged to /var/log/user_management.log.
- **Secure password storage**: Passwords are stored securely in /var/secure/user_passwords.txt.

## Usage

1. **Prepare the Input File**: Create a text file employees.txt with usernames and groups:
    fola;rocky,shade,friends
    wunmi;shade
    frank;friends,rocky 

2. **Clone the Repository**: Clone the repository to your local machine.
    git clone https://github.com/adeyemikafayatfolashade/HNG_stage1_task.git
    cd HNG_stage1_task.git

3. **Set Permissions**: Make the script executable.
    chmod +x create_users.sh

4. **Create Necessary Directories**: Ensure directories for logging and password storage exist.
    sudo mkdir -p /var/secure
    sudo chmod 700 /var/secure

5. **Run the Script**: Execute the script with the input file.
    sudo ./create_users.sh users.txt

**Verification**:

1. **Check if users are created**:
    id fola
    id wunmi
    id frank

2. **Check if groups are created**:
    getent group shade
    getent group rocky
    getent group friends

3. **Check if personal groups are created**:
    getent group fola
    getent group wunmi
    getent group frank

4. **Check if users belong to all specified groups**:
    id fola
    id wunmi
    id frank

5. **Check if passwords are stored securely**:
    sudo ls -l /var/secure/user_passwords.txt

6. **Check log file for actions**:
    sudo less /var/log/user_management.log

## Technical Article

A detailed explanation of the script can be found in the technical article linked below. The article covers the reasoning behind each step in the script, error handling, and best practices.
(https://dly.to/AGykPLk5Lpf)

Learn more about the HNG Internship:
- (https://hng.tech/internship)
- (https://hng.tech/hire) 
