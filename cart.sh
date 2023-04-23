script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=cart
func_schema_setup=mongo

func_nodejs

# func_print_head "Configure NodeJS Repos" 
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# func_print_head "Install NodeJS" 
# yum install nodejs -y

# func_print_head "Create Application User" 
# useradd ${app_user}

# func_print_head "Create Application Directory" 
# rm -rf /app
# mkdir /app 

# func_print_head "Download App Content" 
# curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
# cd /app 

# func_print_head "Unzip Content" 
# unzip /tmp/cart.zip

# # cd /app

# func_print_head "Install NodeJS Dependencies" 
# npm install 

# func_print_head "Copy Cart Service File"
# cp ${script_path}/cart.service /etc/systemd/system/cart.service
# # cp cart.service /etc/systemd/system/cart.service

# func_print_head "Start Cart Service"
# systemctl daemon-reload
# systemctl enable cart 
# systemctl start cart