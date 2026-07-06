docker compose -f /home/msh/docker/compose/docker-compose.yml down smtpserver
docker rmi mservatius/smtpserver:latest
docker build -t smtpserver:latest .
docker tag smtpserver:latest mservatius/smtpserver:latest
docker push mservatius/smtpserver:latest
docker rmi smtpserver:latest
docker rmi mservatius/smtpserver:latest
docker compose -f /home/msh/docker/compose/docker-compose.yml up smtpserver -d