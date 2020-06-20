FROM arm64v8/debian:buster-slim as javabuild
ENV LANG=C.UTF-8

RUN apt update && apt install wget -y

RUN wget https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_aarch64_linux_hotspot_14.0.1_7.tar.gz && \
  tar -zxvf OpenJDK14U-jdk_aarch64_linux_hotspot_14.0.1_7.tar.gz -C /tmp
  
RUN /tmp/jdk-14.0.1+7/bin/jlink --compress=2 \
     --module-path /tmp/jdk-14.0.1+7/jmods/ \
     --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.jdi,jdk.localedata,jdk.scripting.nashorn,jdk.unsupported \
     --output /jlinked


FROM arm64v8/debian:buster-slim
ENV LANG=C.UTF-8
COPY --from=javabuild /jlinked /opt/openjdk

ENV JAVA_HOME=/opt/openjdk/
ENV PATH=$PATH:$JAVA_HOME/bin
