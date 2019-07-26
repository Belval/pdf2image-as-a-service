# Make the directory that will contain the binaries on host
mkdir -p poppler_binaries
# Build the image
docker build -t poppler-build .
# Run the container
docker run -d --name poppler-build-cont poppler-build sleep 20 
#docker exec poppler-build-cont 
sudo docker cp poppler-build-cont:/poppler_binaries .
# Cleaning up
docker kill poppler-build-cont
docker rm poppler-build-cont
docker image rm poppler-build
