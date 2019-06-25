#
# Building poppler-utils in a docker container.
# It's 2019 after all ¯\_(ツ)_/¯
#

# Make the directory that will contain the binaries on host
mkdir -p poppler_binaries
# Build the image
docker build -t poppler-build .
# Run the container
docker run -d --name poppler-build-cont poppler-build sleep 10
# Copy the library & executable files
docker exec poppler-build-cont bash -c "rm -rf /poppler_binaries; mkdir /poppler_binaries; \
                                        cp $(ldconfig -p | grep libjpeg.so.8 | head -n 1 | tr ' ' '\n' | grep /) /poppler_binaries/; \
                                        cp $(ldconfig -p | grep libopenjp2.so.7 | head -n 1 | tr ' ' '\n' | grep /) /poppler_binaries/; \
                                        cp $(ldconfig -p | grep libpng16.so.16 | head -n 1 | tr ' ' '\n' | grep /) /poppler_binaries/; \
                                        cp $(ldconfig -p | grep libz.so.1 | head -n 1 | tr ' ' '\n' | grep /) /poppler_binaries/; \
                                        cp libpoppler* /poppler_binaries/; \
                                        cp utils/pdfinfo /poppler_binaries/; \
                                        cp utils/pdftoppm /poppler_binaries/; \
                                        cp utils/pdftocairo /poppler_binaries/;"
docker cp poppler-build-cont:/poppler_binaries/ .
# Cleaning up
docker kill poppler-build-cont
docker rm poppler-build-cont
docker image rm poppler-build
