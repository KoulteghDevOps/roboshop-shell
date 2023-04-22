script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; 
then
    echo Input MySQL Root Password Missing
    exit
fi

print_head "Install Maven" 
yum install maven -y

print_head "Create App User" 
useradd ${app_user}

print_head "Create App Directory" 
rm -rf /app
mkdir /app 

print_head "Download App Content" 
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
 
print_head "Extract App Content" 
cd /app
unzip /tmp/shipping.zip

# cd /app 

print_head "Download Maven Dependencies" 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar

print_head "Install MySQL" 
yum install mysql -y 

print_head "Load Schema" 
mysql -h mysql-dev.gilbraltar.co.uk -uroot -p${mysql_root_password} < /app/schema/shipping.sql

print_head "Copy Shipping File" 
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
# cp shipping.service /etc/systemd/system/shipping.service

print_head "Start Shipping Service" 
systemctl daemon-reload
systemctl enable shipping 
systemctl start shipping