script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user
schema_setup=mongo
func_nodejs

# func_print_head "Download NodeJS" 
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# func_print_head "Install NodeJS" 
# yum install nodejs -y

# # func_print_head "Copy User Service File" 
# # cp user.service /etc/systemd/system/user.service

# # func_print_head "Copy MongoDB Repo File" 
# # cp mongo.repo /etc/yum.repos.d/mongo.repo

# func_print_head "Create A User"
# useradd ${app_user}

# func_print_head "Create App Directory" 
# rm -rf /app
# mkdir /app 

# func_print_head "Download User File"
# curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
# cd /app 

# func_print_head "Unzip User File" 
# unzip /tmp/user.zip

# # cd /app

# func_print_head "Install User Dependencies" 
# npm install 

# func_print_head "Copy User Service File"
# cp ${script_path}/user.service /etc/systemd/system/user.service

# func_print_head "Start User Service"
# systemctl daemon-reload
# systemctl enable user 
# systemctl start user

# func_print_head Copy MongoDB Repo 
# cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

# func_print_head Installing MongoDB Shell 
# yum install mongodb-org-shell -y

# func_print_head Load Schema 
# mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/user.js

# systemctl restart user

# func_print_head Start User Service 
# systemctl enable user 
# systemctl start user