aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 773331355236.dkr.ecr.eu-central-1.amazonaws.com
docker build -t production .
docker tag production:latest 773331355236.dkr.ecr.eu-central-1.amazonaws.com/production:latest
docker push 773331355236.dkr.ecr.eu-central-1.amazonaws.com/production:latest