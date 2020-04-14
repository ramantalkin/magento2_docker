# magento2_docker

Pull Image from DockerHub :-

"docker pull ramantalkin/magento2_docker:master"

Run your container by following command :-

"docker run -d -p 80:80 -p 3306:3306 ramantalkin/magento2_docker:master"

Note-: No other services should be running on port 80 and 3306 of your host system. If so, change ports in the above docker command.

Your DATABASE NAME for magento installation -: magento2

In order to access the credentials of your database, you have to get the container's console. Run the following command-:

"docker ps" (to get the containers id)

after that run the command

"docker logs container_id"

in that logs you will get the mysql username and password to connect with the database.

To access the database of your magento2 got to the URL http://localhost/magento2/adminer.php and login with the credentials provided in the logs.
