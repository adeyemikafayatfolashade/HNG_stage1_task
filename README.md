Linux User Creation Bash Script
Task Details:
Your company has employed many new developers. As a SysOps engineer, your task is to write a bash script called create_users.sh that reads a text file containing the employee’s usernames and group names, where each line is formatted as user;groups.

The script should:
Create users and groups as specified.
Set up home directories with appropriate permissions and ownership.
Generate random passwords for the users.
Log all actions to /var/log/user_management.log.
Store the generated passwords securely in /var/secure/user_passwords.txt.
Ensure error handling for scenarios like existing users.
Provide clear documentation and comments within the script.

Steps i took in completing the task:
I created the script in my terminal (following all the requirements).

I made the Script Executable:
chmod +x create_users.sh

I created a text file named employees.txt with the required usernames and groups format.

I ran the script:
sudo ./create_users.sh users.txt

I created a new Repository on my github account and uploaded the create_users.sh script.

Technical Article
I wrote a detailed explanation of the script which can be found at  https://dly.to/AGykPLk5Lpf
