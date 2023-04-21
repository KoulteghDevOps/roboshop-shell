echo -e "\e[36m>>>>>>>>> Download NodeJS <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

# echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
# cp user.service /etc/systemd/system/user.service

# echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
# cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download User File <<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip User File <<<<<<<<<\e[0m"
unzip /tmp/user.zip

# cd /app

echo -e "\e[36m>>>>>>>>> Install User Dependencies <<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>> Reload Daemon <<<<<<<<<\e[0m"
systemctl daemon-reload
# systemctl enable user 
# systemctl start user

echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Installing MongoDB Shell <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Updating the DNS <<<<<<<<<\e[0m"
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/user.js

# systemctl restart user

echo -e "\e[36m>>>>>>>>> Start User Service <<<<<<<<<\e[0m"
systemctl enable user 
systemctl start user