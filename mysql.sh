script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; 
then
    echo Input MySQL Root Password Missing
    exit
fi

func_print_head "Disable MySQL 8 Version" 
dnf module disable mysql -y 

func_print_head "Copy MySQL Repo File" 
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo

func_print_head "Install MySQL" 
yum install mysql-community-server -y

func_print_head "Start MySQL"
systemctl enable mysqld
systemctl start mysqld 

func_print_head "Reset Mysql Password" 
mysql_secure_installation --set-root-pass ${mysql_root_password}
mysql -uroot -p${mysql_root_password}