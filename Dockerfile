# TODO: figure out how to use a newer version of linux & opencv
FROM jjanzic/docker-python3-opencv@sha256:5d08b72587cc9a64c6c6f8a6f19a1b1dffe6073b118bb07399ceb673b6c629eb

WORKDIR /

RUN apt-get update && apt-get install -y libfontconfig1 fonts-liberation

RUN wget https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz && \
    wget https://poppler.freedesktop.org/poppler-0.67.0.tar.xz && \
    tar xvf poppler-data-0.4.9.tar.gz && \
    tar xvf poppler-0.67.0.tar.xz && \
    cd poppler-data-0.4.9 && \
    make install && \
    cd .. && \
    cd poppler-0.67.0 && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr && \
    make install && \
    cd ../.. && \
    rm -rf poppler-*


# Fix atrocious font rendering (https://github.com/wkhtmltopdf/wkhtmltopdf/issues/45#issuecomment-108649125)
ADD 100-wkhtmltoimage-special.conf /etc/fonts/conf.d/100-wkhtmltoimage-special.conf
