echo -e "\e[36m>>>>>>>>> Download nodejs <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install Nodejs <<<<<<<<<\e[0m"
yum install nodejs -y

# echo -e "\e[36m>>>>>>>>> Copy Catalogue System File <<<<<<<<<\e[0m"
# cp catalogue.service /etc/systemd/system/catalogue.service

# echo -e "\e[36m>>>>>>>>> Copy Mongo Repo File <<<<<<<<<\e[0m"
# cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Create a User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download App Content <<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip app Content <<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
# cd /app 

echo -e "\e[36m>>>>>>>>> Install NodeJS Dependencies <<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Copy Catalogue System File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>> Start Catalogue Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

echo -e "\e[36m>>>>>>>>> Copy Mongo Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Install Mongo Shell <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Update DNS Record <<<<<<<<<\e[0m"
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/catalogue.js

echo -e "\e[36m>>>>>>>>> Restart Catalogue Service <<<<<<<<<\e[0m"
systemctl restart catalogue