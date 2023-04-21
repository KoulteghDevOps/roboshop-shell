echo -e "\e[36m>>>>>>>>> Download NodeJS <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>> Copy Cart Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/cart.service /etc/systemd/system/cart.service
# cp cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create A App directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Cart File <<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Cart File <<<<<<<<<\e[0m"
unzip /tmp/cart.zip

# cd /app

echo -e "\e[36m>>>>>>>>> Install Cart Dependencies <<<<<<<<<\e[0m"
npm install 

# cp catalogue.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>> Start Cart Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart 
systemctl start cart