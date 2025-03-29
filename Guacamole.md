### Установка и настройка Guacamole с PostgreSQL через docker compose

#### 0. Создаем файл docker_compose.yml

```yaml
version: '3'

networks:
  net:
    ipam:
      config:
        - subnet: 192.168.100.1/24

volumes:
  db:
  shared:

services:
  db:
    container_name: guacamole_db
    image: postgres:15
    networks:
      - net
    volumes:
      - db:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: guacamole
      POSTGRES_USER: guacamole
      POSTGRES_PASSWORD: some_pass
    restart: always

  guacd:
    container_name: guacamole_guacd
    image: guacamole/guacd
    networks:
      - net
    volumes:
      - shared:/home/guacd/shared
    restart: always

  guacamole:
    depends_on:
      - db
      - guacd
    container_name: guacamole_guacamole
    image: guacamole/guacamole
    networks:
      - net
    ports:
      - 8080:8080
    environment:
      GUACD_HOSTNAME: guacd
      POSTGRESQL_HOSTNAME: db
      POSTGRESQL_DATABASE: guacamole
      POSTGRESQL_USER: guacamole
      POSTGRESQL_PASSWORD: some_pass
    restart: always
```

---

#### 1. Создаем контейнеры (не запуская)
```bash
 docker-compose up --no-start
```

#### 2. Создаем файл для инициализации базы данных
Guacamole предоставляет скрипт для инициализации базы данных PostgreSQL:
```bash
 docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > ./init/initdb.sql
```

#### 3. Копируем созданный файл в контейнер базы данных
```bash
 docker cp ./initdb.sql guacamole_db:/tmp/initdb.sql
```

#### 4. Запускаем контейнер базы данных
```bash
 docker container start guacamole_db
```
#### 5. Подключаемся к консоли PostgreSQL
Используйте следующую команду для подключения к PostgreSQL:
```bash
docker exec -it guacamole_db psql -U guacamole -d guacamole
```

#### 6. Инициализируем базу данных
Выполните следующие команды в консоли PostgreSQL:
```sql
\i /tmp/initdb.sql
```

#### 7. Отключаемся от консоли PostgreSQL
```sql
\q
```

#### 8. Запускаем контейнеры `guacd` и `guacamole`
```bash
docker container start guacamole_guacd guacamole_guacamole
```
---

### Настройка Guacamole через веб-интерфейс

1. Откройте браузер и перейдите по адресу:
   ```
   http://guacamole.domain.local:8080/guacamole/
   ```

2. Авторизуйтесь с использованием логина `guacadmin` и пароля `guacadmin`.

3. Перейдите в разделы **Опции** → **Подключения** и создайте новое подключение:
   - **Название**: test
   - **Протокол**: rdp
   - **Настройки**:
     - **Сеть**:
       - Сервер: `test.domain.local`
       - Порт: `3389`
     - **Аутентификация**:
       - Режим безопасности: RDP-шифрование
     - **Clipboard**:
       - Line endings: Windows (CRLF)
     - **Перенаправление устройств**:
       - Включить диск: включено
       - Название диска: Shared Drive
       - Путь для диска: `/home/guacd/shared/${GUAC_USERNAME}`
       - Автоматически создавать путь для диска: включено

4. Вернитесь на главную страницу и выполните подключение.

---
