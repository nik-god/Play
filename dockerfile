FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    openjdk-11-jdk \
    inetutils-ping

RUN apt-get install -y curl && \
    curl -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x /usr/local/bin/lein

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV LEIN_HOME=/root/.lein

# Display installed versions
RUN java -version && \
    python3 --version && \
    lein version



WORKDIR /project/wepapp

COPY . /project/wepapp/
RUN make libs && \
    make test  && \
    make clean all



# Run a command that keeps the container running
CMD tail -f /dev/null
