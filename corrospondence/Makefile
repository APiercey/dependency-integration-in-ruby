up:
	docker-compose up -d

down:
	docker-compose down -v

create_database:
	docker-compose run web bundle exec rails db:create

migrate_database:
	docker-compose run web bundle exec rails db:migrate

seed_database:
	docker-compose run web bundle exec rails db:seed

setup: up create_database migrate_database seed_database

