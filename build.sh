ext=$1
docker build --no-cache -t skhatri/open-notebook -f Dockerfile$ext .

