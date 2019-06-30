ifndef u
u:=root
endif

ifndef env
env:=dev
endif

OS:=$(shell uname)

docker-start:
	docker-compose up -d

docker-restart:
	docker-compose down
	make docker-start

docker-connect: 
	docker exec -it laravel-swoole  ash

init-app:
	cp .env.example .env
	composer install
	php artisan key:generate
	php artisan migrate
	php artisan db:seed
docker-init:
	docker exec -it laravel-swoole make init-app

log:
	tail -f storage/logs/laravel.log

test-js:
	npm test

test-php:
	vendor/bin/phpcs --standard=phpcs.xml && vendor/bin/phpmd app text phpmd.xml

build:
	npm run dev

cache:
	php artisan cache:clear && php artisan view:clear

docker-cache:
	docker exec laravel-swoole make cache


