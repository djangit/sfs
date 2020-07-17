FROM fedora:32

ENV http_proxy=http://proxy1.si.c-s.fr:3128
ENV https_proxy=http://proxy1.si.c-s.fr:3128
ENV no_proxy=loclahost,127.0.0.1,si.c-s.fr
#ENV no_proxy = 0.0.0.0/0


#RUN dnf update -y
RUN dnf -y install npm nodejs git openssl 

RUN git clone https://github.com/crivaledaz/Secure_File_Server.git /opt/Secure_File_Server/


WORKDIR /opt/Secure_File_Server/

RUN npm install && \
    #mkdir files/ && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout key.pem -out cert.pem -subj "/C=FR/ST=IDF/L=Plessis/O=CSGroup/OU=CIaaS/CN=example.com"

#RUN dnf install procps, net-tools

#COPY *.json .
#COPY upload.html .

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh


EXPOSE 443 80

ENTRYPOINT ["/opt/Secure_File_Server/entrypoint.sh"]
