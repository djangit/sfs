# Dockerfile with fixed and clear reCaptcha key for deployment test with OKD4
# run successfully with the following command : podman run -d -p 8080:80 -p 8443:443 sfs1
FROM fedora:32

ENV http_proxy=http://proxy1.si.c-s.fr:3128
ENV https_proxy=http://proxy1.si.c-s.fr:3128


#RUN dnf update -y
RUN dnf -y install npm nodejs git openssl 

RUN git clone https://github.com/crivaledaz/Secure_File_Server.git /opt/Secure_File_Server/


WORKDIR /opt/Secure_File_Server/

RUN npm install && \
    #mkdir files/ && \
    #openssl req -x509 -nodes -newkey rsa:2048 -keyout key.pem -out cert.pem
    openssl req -x509 -nodes -newkey rsa:2048 -keyout /opt/Secure_File_Server/key.pem -out /opt/Secure_File_Server/cert.pem -subj "/C=FR/ST=IDF/L=Plessis/O=CSGroup/OU=CIaaS/CN=localhost"

RUN chmod 777 /opt/Secure_File_Server/key.pem /opt/Secure_File_Server/cert.pem


RUN mkdir files
VOLUME /opt/Secure_File_Server/files


#RUN dnf install procps, net-tools

#COPY *.json .
#COPY upload.html .

# COPY entrypoint.sh .
# RUN chmod +x entrypoint.sh
RUN sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/6LdpNfYUAAAAAFN2ZkJYAJSiCjswOEfiFy8-ZGag/g" config.json  && \
    sed -i "s/YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY/6LdpNfYUAAAAAPCKCqorfvN3RtijAdtAtpoQxBKG/g" config.json && \
    sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/6LdpNfYUAAAAAFN2ZkJYAJSiCjswOEfiFy8-ZGag/g" upload.html && \
    sed -i '/"portHTTP"/d' config.json
#    sed -i "s/443/8443/g" config.json



EXPOSE 8443

# ENTRYPOINT ["/opt/Secure_File_Server/entrypoint.sh"]
CMD ["node", "/opt/Secure_File_Server/index.js"]
