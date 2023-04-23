script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Python36" 
yum install python36 gcc python3-devel -y

func_print_head "Create App User"
useradd ${app_user}

func_print_head "Create App Directory" 
rm -rf /app
mkdir /app 

func_print_head "Download Payment File" 
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 

func_print_head "Unzip Payment File"
unzip /tmp/payment.zip
# cd /app 

func_print_head "Install Python Dependencies" 
pip3.6 install -r requirements.txt

func_print_head "Copy Payment Service File"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service
# cp payment.service /etc/systemd/system/payment.service

func_print_head "Start Payment Service" 
systemctl daemon-reload
systemctl enable payment 
systemctl start payment