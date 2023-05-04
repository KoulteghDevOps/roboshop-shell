script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit 1
fi

component=payment
func_python

# func_print_head "Install Python36" 
# yum install python36 gcc python3-devel -y

# func_print_head "Create Application User"
# useradd ${app_user}

# func_print_head "Create Application Directory" 
# rm -rf /app
# mkdir /app 

# func_print_head "Download Application File" 
# curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
# cd /app 

# func_print_head "Unzip Application Content"
# unzip /tmp/${component}.zip
# # cd /app 

# func_print_head "Install Applicatioin Dependencies" 
# pip3.6 install -r requirements.txt

# func_print_head "Copy ${component} Service File"
# sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/${component}.service
# cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
# # cp ${component}.service /etc/systemd/system/${component}.service

# func_print_head "Start ${component} Service" 
# systemctl daemon-reload
# systemctl enable ${component} 
# systemctl start ${component}