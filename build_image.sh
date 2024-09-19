docker buildx create --name mybuilder --use
docker buildx inspect --bootstrap
docker buildx build --platform linux/amd64,linux/arm64 -t wordpress-enhanced:latest .
docker tag wordpress-enhanced:latest registry.kratochvil.eu/wordpress-enhanced:latest
docker tag wordpress-enhanced:latest registry.kratochvil.eu/wordpress-enhanced:6-php8.2-apache
docker push registry.kratochvil.eu/wordpress-enhanced:latest
docker push registry.kratochvil.eu/wordpress-enhanced:6-php8.2-apache