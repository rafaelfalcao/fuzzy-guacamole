FROM python:3.6.5

RUN pip install --upgrade pip \
    &&  pip install awscli \
	&& pip install boto3

FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3.9 python3.9-dev
COPY . .
