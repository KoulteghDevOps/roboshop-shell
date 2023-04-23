script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Install Redis Repo" 
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

func_print_head "Enable Redis Repo" 
dnf module enable redis:remi-6.2 -y

func_print_head "Install Redis" 
yum install redis -y 

func_print_head "Substitute the IP Address" 
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf

func_print_head "Start Redis" 
systemctl enable redis 
systemctl start redis 