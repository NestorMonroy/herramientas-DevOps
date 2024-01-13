touch .env
echo CURRENT_UID=$(id -u):$(id -g) >> .env

docker compose -f docker-compose.yml up -d