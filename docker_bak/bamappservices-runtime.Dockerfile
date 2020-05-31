# Build
FROM bamapps/bamtoolkit-sdk:latest AS build-env

RUN apt-get update \
    && apt-get install -y --no-install-recommends git-core curl build-essential openssl libssl-dev unzip python3 \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /root/.bam/src

WORKDIR /root 

COPY . ./

RUN mv ./_ssh/ ./.ssh \
    && chmod 700 ./.ssh \
    && chmod 644 ./.ssh/id_rsa.pub \
    && chmod 600 ./.ssh/id_rsa \
    && git clone git@github.com:BryanApellanes/BamAppServices.git ./.bam/src/BamAppServices

WORKDIR /root/.bam/src/BamAppServices

ENV DIST=/tmp/bam
ENV BAMAPPSERVICESBIN=/root/.bam/appservices/bin
ENV BAMAPPSERVICESSYMLINKS=/usr/local/bin
RUN ./build.sh \
    && ./install.sh \
    && ./symlink-appservices.sh /usr/local/bin /root/.bam/appservices/bin

WORKDIR /root 
RUN rm -fr /root/.bam/src

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends git-core curl build-essential openssl libssl-dev unzip python3 \
    && rm -rf /var/lib/apt/lists/* 

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /root

COPY . ./
RUN ./install-nodejs.sh

COPY --from=build-env /root/.bam ./.bam
COPY --from=build-env /usr/local/bin /usr/local/bin
ENV ASPNETCORE_ENVIRONMENT=PROD
ENV PATH "$PATH:/usr/local/bin"

