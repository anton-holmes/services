
# запускаем веб сервер
version: '3.7'

services:
  nginx:
    container_name: mynginx
    image: nginx:latest
    networks:
      nginx_net:
    volumes:
      - ./nginx:/etc/nginx
    ports:
      - 80:80

networks:
  nginx_net:
    name: nginx_net


# Скопируем каталог с конфигурацией
docker cp mynginx:/etc/nginx .


# Запустим первое приложение
docker run -itd --network=nginx_net --name learngit 451777/learngit 

# Создаем новый конфигурационный файл
nginx/conf.d/learngit.conf

# Добавляем следующее содержимое

server {
  server_name bankz.com;

  location / {
    resolver 127.0.0.11; # DNS server dovker
    set $project http://learngit:80;

    proxy_pass $project;
  }
}

# Меняем файл имитирую dns server
/etc/hosts

127.0.0.1       bankz.com
127.0.0.1       bank.com

# Передаем сигнал на перезагрузку
docker exec -t my_nginx nginx -s reload

# Если возникают проблемы с resolver прочетайте комментарии
https://stackoverflow.com/questions/35744650/docker-network-nginx-resolver


