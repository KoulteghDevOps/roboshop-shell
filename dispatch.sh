script_path=$(dirname $0)
source $(script_path)/common.sh

echo -e "\e[36m>>>>>>>>> Install Golang <<<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd $(app_user)

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Dispatch File <<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Dispatch File <<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip

# cd /app 

echo -e "\e[36m>>>>>>>>> Build Dispatch File <<<<<<<<<\e[0m"
go mod init dispatch
go get 
go build

echo -e "\e[36m>>>>>>>>> Copy Dispatch Service File <<<<<<<<<\e[0m"
# cp dispatch.service /etc/systemd/system/dispatch.service
cp $(script_path)/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m>>>>>>>>> Start Dispatch Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch