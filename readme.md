Simple docker LAMP stack

```
sudo docker build -t phptest . && sudo docker run --name test_instance -itd -p 8083:80 -v $(pwd)/app:/var/www/html phptest

```