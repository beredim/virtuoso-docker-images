docker build -t beredim/virtuoso:base -f Dockerfile-base .
docker build -t beredim/virtuoso:minimal -f Dockerfile-minimal .
docker build -t beredim/virtuoso:2g -f Dockerfile-2g .
docker build -t beredim/virtuoso:4g -f Dockerfile-4g .
docker build -t beredim/virtuoso:8g -f Dockerfile-8g .
