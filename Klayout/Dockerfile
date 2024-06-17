# Use an official Fedora as a parent image
FROM fedora:40 as builder

# Define build-time arguments
ARG KLAYOUT_VERSION

# Set the environment variables
ENV KLAYOUT_VERSION ${KLAYOUT_VERSION}

# Install necessary packages
RUN dnf update -y && \
    dnf install -y \
    git \
    make \
    gcc \
    g++ \
    qt5-qtbase \
    qt5-qtbase-devel \
    qt5-qtmultimedia \ 
    qt5-qtmultimedia-devel \ 
    qt5-qtxmlpatterns \ 
    qt5-qtxmlpatterns-devel \ 
    qt5-qtsvg \ 
    qt5-qtsvg-devel \ 
    qt5-qttools \
    qt5-qttools-devel \
    zlib-devel \
    ruby \
    ruby-devel \
    python3 \
    python3-devel \
    libgit2-devel &&\
    dnf clean all

# Clone the klayout repository 
RUN git clone https://github.com/KLayout/klayout.git /opt/klayout-${KLAYOUT_VERSION} && \
    cd /opt/klayout-${KLAYOUT_VERSION} && \
    git checkout v${KLAYOUT_VERSION}

# Build klayout and install it
RUN cd /opt/klayout-${KLAYOUT_VERSION} && \
    /opt/klayout-${KLAYOUT_VERSION}/build.sh -prefix /opt/klayout-${KLAYOUT_VERSION} -option "-j $(nproc)"


