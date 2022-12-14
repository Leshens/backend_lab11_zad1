version: "3.8"

services:
  accesslog:
    image: diamol/ch09-access-log
    ports:
      - "80"
    networks:
      - app-net

  iotd:
    image: diamol/ch09-image-of-the-day
    ports:
      - "8011:80"
    networks:
      - app-net

  image-gallery:
    image: diamol/ch09-image-gallery
    ports:
      - "8010:80"
    depends_on:
      - accesslog
      - iotd
    networks:
      - app-net

  prometheus:
    image: mmiotkug/prometheus-image:1.0
    ports:
      - "9090:9090"
    networks:
      - app-net

  grafana:
    image: diamol/ch09-grafana
    ports:
      - "3000:3000"
    depends_on:
      - prometheus
    networks:
      - app-net


networks:
  app-net:
    external:
      name: nat
