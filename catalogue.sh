script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue
func_schema_setup=mongo
func_nodejs

# print_head "Download nodejs" 
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# print_head "Install Nodejs" 
# yum install nodejs -y

# # print_head "Copy Catalogue System File" 
# # cp catalogue.service /etc/systemd/system/catalogue.service

# # print_head "Copy Mongo Repo File" 
# # cp mongo.repo /etc/yum.repos.d/mongo.repo

# print_head "Create a User" 
# useradd ${app_user}

# print_head "Create App Directory" 
# rm -rf /app
# mkdir /app 

# print_head "Download App Content" 
# curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
# cd /app 

# print_head "Unzip app Content" 
# unzip /tmp/catalogue.zip
# # cd /app 

# print_head "Install NodeJS Dependencies" 
# npm install 

# print_head "Copy Catalogue System File" 
# cp ${script_path}/catalogue.service /etc/systemd/system/catalogue.service

# print_head "Start Catalogue Service" 
# systemctl daemon-reload
# systemctl enable catalogue 
# systemctl start catalogue

# print_head "Copy Mongo Repo File" 
# cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

# print_head "Install Mongo Shell" 
# yum install mongodb-org-shell -y

# print_head "Load Schema" 
# mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/catalogue.js

# print_head "Restart Catalogue Service" 
# systemctl restart catalogue