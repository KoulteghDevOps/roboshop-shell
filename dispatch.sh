script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Golang" 
yum install golang -y
func_status_check $?

func_print_head "Create A User" 
useradd ${app_user}
func_status_check $?

func_print_head "Create App Directory" 
rm -rf /app
mkdir /app 
func_status_check $?

func_print_head "Download Dispatch File" 
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
func_status_check $?

func_print_head "Unzip Dispatch File" 
unzip /tmp/dispatch.zip
func_status_check $?

# cd /app 

func_print_head "Build Dispatch File"
go mod init dispatch
go get 
go build
func_status_check $?

func_print_head "Copy Dispatch Service File" 
# cp dispatch.service /etc/systemd/system/dispatch.service
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
func_status_check $?

func_print_head "Start Dispatch Service"
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch
func_status_check $?