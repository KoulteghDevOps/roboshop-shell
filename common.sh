app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<\e[0m"
}

func_schema_setup() {
  if [ "$func_schema_setup" == "mongo" ]; then
    func_print_head "Copy MongoDB Repo" 
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

    func_print_head "Installing MongoDB Client" 
    yum install mongodb-org-shell -y

    func_print_head "Load Schema" 
    mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/${component}.js
  fi 
  if [ "$func_schema_setup" == "mysql" ]; then
    func_print_head "Install MySQL" 
    yum install mysql -y 

    func_print_head "Load Schema" 
    mysql -h mysql-dev.gilbraltar.co.uk -uroot -p${mysql_root_password} < /app/schema/${component}.sql
  fi
}


func_app_prereq() {
  func_print_head "Create Application User" 
  useradd ${app_user}

  func_print_head "Create Application Directory" 
  rm -rf /app
  mkdir /app 

  func_print_head "Download Application Content" 
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
  
  func_print_head "Extract Application Content" 
  cd /app
  unzip /tmp/${component}.zip

  # cd /app 
}

func_systemd_setup() {
  func_print_head "Setup SystemD Service" 
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  # cp ${component}.service /etc/systemd/system/${component}.service

  func_print_head "Start ${component} Service" 
  systemctl daemon-reload
  systemctl enable ${component} 
  systemctl start ${component}
}

func_nodejs() {
  func_print_head "Configure NodeJS Repos" 
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "Install NodeJS" 
  yum install nodejs -y

  func_app_prereq

  func_print_head "Install NodeJS Dependencies" 
  npm install
  
  func_schema_setup 

  func_systemd_setup
}

func_java() {
  func_print_head "Install Maven" 
  yum install maven -y

  func_app_prereq

  func_print_head "Download Maven Dependencies" 
  mvn clean package 
  mv target/${component}-1.0.jar ${component}.jar

  func_schema_setup

  func_systemd_setup
}
