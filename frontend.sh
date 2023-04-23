script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Nginx" 
dnf install nginx -y 

func_print_head "Copy App Config File" 
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf
# cp roboshop.conf /etc/nginx/default.d/roboshop.conf

func_print_head "Empty the HTML Location" 
rm -rf /usr/share/nginx/html/* 

func_print_head "Download Frontend File"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

func_print_head "Change Directory to Nginx HTML" 
cd /usr/share/nginx/html 

func_print_head "Unzip App File"
unzip /tmp/frontend.zip

func_print_head "Start Nginx" 
systemctl enable nginx 
systemctl start nginx