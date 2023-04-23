script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue
func_schema_setup=mongo
func_nodejs

# func_print_head "Download nodejs" 
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# func_print_head "Install Nodejs" 
# yum install nodejs -y

# # func_print_head "Copy Catalogue System File" 
# # cp catalogue.service /etc/systemd/system/catalogue.service

# # func_print_head "Copy Mongo Repo File" 
# # cp mongo.repo /etc/yum.repos.d/mongo.repo

# func_print_head "Create a User" 
# useradd ${app_user}

# func_print_head "Create App Directory" 
# rm -rf /app
# mkdir /app 

# func_print_head "Download App Content" 
# curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
# cd /app 

# func_print_head "Unzip app Content" 
# unzip /tmp/catalogue.zip
# # cd /app 

# func_print_head "Install NodeJS Dependencies" 
# npm install 

# func_print_head "Copy Catalogue System File" 
# cp ${script_path}/catalogue.service /etc/systemd/system/catalogue.service

# func_print_head "Start Catalogue Service" 
# systemctl daemon-reload
# systemctl enable catalogue 
# systemctl start catalogue

# func_print_head "Copy Mongo Repo File" 
# cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

# func_print_head "Install Mongo Shell" 
# yum install mongodb-org-shell -y

# func_print_head "Load Schema" 
# mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/catalogue.js

# func_print_head "Restart Catalogue Service" 
# systemctl restart catalogue