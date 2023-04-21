echo -e "\e[36m>>>>>>>>> Install Nginx <<<<<<<<<<<\e[0m"
dnf install nginx -y 

echo -e "\e[36m>>>>>>>>> Copy App Config File <<<<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf
# cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>>> Empty the HTML Location <<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[36m>>>>>>>>> Download Frontend File <<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

echo -e "\e[36m>>>>>>>>> Change Directory to Nginx HTML <<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html 

echo -e "\e[36m>>>>>>>>> Unzip App File <<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>>> Start Nginx <<<<<<<<<<<\e[0m"
systemctl enable nginx 
systemctl start nginx