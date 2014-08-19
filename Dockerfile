FROM ubuntu:14.04
MAINTAINER David Rathmann, drathm@bitfuzion.com

ENV SBT_VERSION 0.13.5

# Update
RUN apt-get -y update \
  && apt-get -y upgrade

# Install Dependencies
RUN apt-get -y install \
  software-properties-common \
  telnet curl zip git-core docker.io \
  && ln -s /usr/bin/docker.io /usr/local/bin/docker

RUN add-apt-repository -y ppa:webupd8team/java \
  && apt-get -y update \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \
  && apt-get -y install oracle-java8-installer

# Install sbt
RUN curl -L -o /tmp/sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i /tmp/sbt-$SBT_VERSION.deb && \
  rm -f /tmp/sbt-$SBT_VERSION.deb

# Install sbt extras
RUN curl -s https://raw.github.com/paulp/sbt-extras/master/sbt > /usr/local/bin/sbt-extra && \
  chmod 0755 /usr/local/bin/sbt-extra

# Print versions
RUN java -version
RUN sbt --version || true

# Add dev user and add docker root user to sudoers
RUN addgroup --gid=1001 core \
  && adduser --uid=1001 --ingroup core --disabled-password --gecos "" core \
  && passwd -d core \
  && usermod -a -G sudo core \
  && echo "%root  ALL=(ALL:ALL) ALL" >> /etc/sudoers \
  && chmod u+s /usr/bin/sudo

# Set working directory
ENV HOME /home/core
WORKDIR /home/core
USER core
