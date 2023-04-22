script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "Install Golang" 
yum install golang -y

print_head "Create A User" 
useradd ${app_user}

print_head "Create App Directory" 
rm -rf /app
mkdir /app 

print_head "Download Dispatch File" 
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 

print_head "Unzip Dispatch File" 
unzip /tmp/dispatch.zip

# cd /app 

print_head "Build Dispatch File"
go mod init dispatch
go get 
go build

print_head "Copy Dispatch Service File" 
# cp dispatch.service /etc/systemd/system/dispatch.service
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service

print_head "Start Dispatch Service"
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch