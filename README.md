# Php Development with Docker
### Introduction
If you want to start developing with php, and you need some servers to be running quickly, then this repo can help you to start having the following:

1. Php-fpm + Nginx web server, that you can also change the required settings to point to your website
2. Php-ssh, this image is usefule to let you use and debug your code line by line by using some other IDE, for example you can use it with phpstorm.
3. Php-cli, this image is useful to run long processes and other php scripts
4. elasticsearch, this image has kibana and sense also, so you can watch your indexes on your web browser
5. redis, this image can be used in your project as a key value server, and use it as a caching server

**Note:**
All the php-* images have zeromq installed, supervisor, xdebug, and pcntl extension for process control support, and other php extensions.

### Instructions
1. Install docker on your machine, see [Docker Installation](https://docs.docker.com/engine/installation/)
2. Install docker compose, see [Docker Compose Installation](https://docs.docker.com/compose/install/)
3. Clone the repo 
 ```sh
 git clone https://github.com/arkanmgerges/php-dev-with-docker.git
 cd php-dev-with-docker 
 ```
4. Open docker-compose.yml file, and modify **data** service, **volumes** option to point to your project files
5. Change the path in the **php-fpm** service, **volumes** option to point to the temporary directory in your machine, you can then use xdebug profiling and collect the data in this folder
6. Open **config/nginx/site.conf** file and modify it to suit your project configuration need
7. Issue the command from the folder where the docker-compose.yml is. This command will pull all the necessary images if you don't have them in your computer, then it will start the services in the background
 ```sh
 docker-compose up -d
 ```
8. Issue the command to see that php-fpm, php-ssh, web-nginx, es01, redis01 are up except php-cli and data which is ok
 ```sh
 docker-compose ps
 ```

### Setting for PhpStorm to Use php-ssh container
Open your phpstorm settings from **File -> Settings**, under **Languages & Framework**, choose **PHP**
from the **Interpreter** click on the **...**, a new window will open (Interpreters Window), click on the **+ sign** and
choose **Remote...**, Then Write **Remote PHP 7** in the **Name field**, click on the **SSH Credentials** and write your docker machine ip address (on windows there is a possibility that docker will be installed on the virtual box, and this virtual box will have its own ip), write in the port **1122**, write in the Username **root**, and **1234** in the Password, write **/usr/local/bin/php** in the PHP executable. Click **Ok**

**Note:** To check your docker machine ip address, issue this command
```sh
docker-machine ip
```
This is how I used it on my machine which is running Windows 10 Home Edition


