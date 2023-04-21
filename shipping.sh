echo -e "\e[36m>>>>>>>>> Install Maven <<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Shipping File <<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Shipping File <<<<<<<<<\e[0m"
unzip /tmp/shipping.zip

# cd /app 

echo -e "\e[36m>>>>>>>>> Package Maven <<<<<<<<<\e[0m"
mvn clean package 

echo -e "\e[36m>>>>>>>>> Move Sippinig Jars to New Location <<<<<<<<<\e[0m"
mv target/shipping-1.0.jar shipping.jar 

echo -e "\e[36m>>>>>>>>> Copy Shipping File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/shipping.service /etc/systemd/system/shipping.service
# cp shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>>>> Start Shipping Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping 
systemctl start shipping

echo -e "\e[36m>>>>>>>>> Install MySQL <<<<<<<<<\e[0m"
yum install mysql -y 

echo -e "\e[36m>>>>>>>>> Update DNS Record <<<<<<<<<\e[0m"
mysql -h mysql-dev.gilbraltar.co.uk -uroot -pRoboShop@1 < /app/schema/shipping.sql 

echo -e "\e[36m>>>>>>>>> Restart Shipping Service <<<<<<<<<\e[0m"
systemctl restart shipping