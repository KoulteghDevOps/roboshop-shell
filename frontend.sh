script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Nginx" 
dnf install nginx -y &>>$log_file
func_status_check $?

func_print_head "Copy App Config File" 
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file
func_status_check $?
# cp roboshop.conf /etc/nginx/default.d/roboshop.conf

func_print_head "Clean Old App Content" 
rm -rf /usr/share/nginx/html/* &>>$log_file
func_status_check $?

func_print_head "Downloading App Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
func_status_check $?

func_print_head "Extracting App Content" 
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
func_status_check $?

func_print_head "Start Nginx" 
systemctl enable nginx &>>$log_file
systemctl start nginx &>>$log_file
func_status_check $?