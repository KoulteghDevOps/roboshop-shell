echo -e "\e[36m>>>>>>>>> Install Python36 <<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>> Create User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Payment File <<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Payment File <<<<<<<<<\e[0m"
unzip /tmp/payment.zip
# cd /app 

echo -e "\e[36m>>>>>>>>> Install Python Dependencies <<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>> Copy Payment Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/payment.service /etc/systemd/system/payment.service
# cp payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>> Start Payment Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl start payment