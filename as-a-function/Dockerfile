FROM ubuntu:18.04

# Installing dependencies
RUN apt update
RUN apt-get update
RUN apt-get install -y locate \
                       libopenjp2-7 \
                       poppler-utils

RUN rm -rf /poppler_binaries;  mkdir /poppler_binaries;
RUN updatedb
RUN cp $(locate libpoppler.so) /poppler_binaries/.
RUN cp $(which pdftoppm) /poppler_binaries/.
RUN cp $(which pdfinfo) /poppler_binaries/.
RUN cp $(which pdftocairo) /poppler_binaries/.
RUN cp $(locate libjpeg.so.8 ) /poppler_binaries/.
RUN cp $(locate libopenjp2.so.7 ) /poppler_binaries/.
RUN cp $(locate libpng16.so.16 ) /poppler_binaries/.
RUN cp $(locate libz.so.1 ) /poppler_binaries/.
RUN cp $(locate libfreetype.so.6 ) /poppler_binaries/.
RUN cp $(locate libfontconfig.so.1 ) /poppler_binaries/.
RUN cp $(locate libnss3.so ) /poppler_binaries/.
RUN cp $(locate libsmime3.so ) /poppler_binaries/.
RUN cp $(locate liblcms2.so.2 ) /poppler_binaries/.
RUN cp $(locate libtiff.so.5 ) /poppler_binaries/.
RUN cp $(locate libexpat.so.1 ) /poppler_binaries/.
RUN cp $(locate libjbig.so.0 ) /poppler_binaries/.
