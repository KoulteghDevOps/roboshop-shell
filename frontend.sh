script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "Install Nginx" 
dnf install nginx -y 

print_head "Copy App Config File" 
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf
# cp roboshop.conf /etc/nginx/default.d/roboshop.conf

print_head "Empty the HTML Location" 
rm -rf /usr/share/nginx/html/* 

print_head "Download Frontend File"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

print_head "Change Directory to Nginx HTML" 
cd /usr/share/nginx/html 

print_head "Unzip App File"
unzip /tmp/frontend.zip

print_head "Start Nginx" 
systemctl enable nginx 
systemctl start nginx