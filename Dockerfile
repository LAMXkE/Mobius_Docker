FROM ubuntu:22.04
LABEL maintainer="sametim17@gmail.com"

ENV MYSQL_ROOT_PASSWORD=1q2w3e4r
ENV CSEBASEPORT=7579

RUN apt-get -y update > /dev/null
RUN apt-get install -y curl git make build-essential > /dev/null
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - > /dev/null
RUN apt-get install -y mysql-server > /dev/null

RUN apt-get install -y nodejs > /dev/null

WORKDIR /app
RUN git clone "https://github.com/IoTKETI/Mobius"

WORKDIR /app/Mobius
RUN npm install

RUN echo '{ \
    "csebaseport": "'${CSEBASEPORT}'",\
    "dbpass": "'${MYSQL_ROOT_PASSWORD}'" \
}' > conf.json

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE ${CSEBASEPORT}
ENTRYPOINT ["/start.sh"]