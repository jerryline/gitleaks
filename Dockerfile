FROM ubuntu:18.04


RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y gcc \
                       g++ \
                       curl \
                       jq \
                       build-essential \
                       libssl-dev \
                       libffi-dev \
                       docker \
                      # ansible \
                       wget \
                       openjdk-11-jre \
                       vim \
                       zip \
                       git \
                       ssh \
                       awscli
RUN apt-get clean
RUN apt-get install --fix-missing

RUN which java


#set java environment
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH=$PATH:$JAVA_HOME/bin

RUN java -version

#python2.7

RUN apt-get install python-pip python-dev -y
RUN pip install --upgrade pip 
RUN pip install boto3 && \
    pip install botocore && \
    pip install boto==2.42.0 && \
    pip install ansible==2.10.4
    
WORKDIR /go/src/repoleaks
COPY . .
CMD ["go", "run", "main.go"]

# How to use me :

# docker build -t gitleaks .
# docker run --rm --name=gitleaks gitleaks --repo=https://github.com/zricethezav/gitleaks

# This will check for secrets in https://github.com/zricethezav/gitleaks
