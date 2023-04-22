app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head() {
    echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<\e[0m"
}

func_schema_setup() {
  if [ "$func_scheme_setup" == "mongo" ]; then
    print_head "Copy MongoDB Repo" 
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

    print_head "Installing MongoDB Client" 
    yum install mongodb-org-shell -y

    print_head "Load Schema" 
    mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/${component}.js
  fi
}

func_nodejs() {
    print_head "Configure NodeJS Repos" 
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash

    print_head "Install NodeJS" 
    yum install nodejs -y

    print_head "Create Application User" 
    useradd ${app_user}

    print_head "Create Application Directory" 
    rm -rf /app
    mkdir /app 

    print_head "Download App Content" 
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
    cd /app 

    print_head "Unzip Content" 
    unzip /tmp/${component}.zip

    # cd /app

    print_head "Install NodeJS Dependencies" 
    npm install 

    print_head "Create Application Directory" 
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
    # cp ${component}.service /etc/systemd/system/${component}.service

    print_head "Start ${component}" Service 
    systemctl daemon-reload
    systemctl enable ${component} 
    systemctl start ${component}

    func_schema_setup
}
