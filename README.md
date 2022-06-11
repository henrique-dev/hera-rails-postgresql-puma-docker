# Rails Postgresql Puma Docker
## Description
This is a 1-click Rails project template configured with Docker, PostgreSQL and Puma.

## Requirements:
- Docker
- Docker Compose

## Installation
Create a new project using this as a template.
After that clone and enter the directory of the new project run the script `setup.sh`, putting as the first parameter the name of the application and the second parameter the port for external access:
```
./setup.sh nome_aplicacao porta
```
> Ex.: ./setup.sh top_project 8020

Then run:
```
docker-compose build
docker-compose up
```

And finally, don't forget to create the database and perform the migration if any:
```
docker-compose run nome_aplicacao rails db:create
docker-compose run nome_aplicacao rails db:migrate
```
