FROM ubuntu:18.04
RUN apt update -y \
    && apt install -y apache2 \
    && apt-get install -y libapache2-mod-security2 \
    && apt install -y git
RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf \
    && rm -rf /usr/share/modsecurity-crs \
    && git clone https://github.com/coreruleset/coreruleset.git /usr/share/modsecurity-crs \
    && cp /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf 
RUN cd /etc/apache2 \
    && printf "Include /usr/share/modsecurity-crs/crs-setup.conf\nInclude /usr/share/modsecurity-crs/rules/*.conf" >> apache2.conf \
    && sed -i -e 's/SecRuleEngine DetectionOnly/SecRuleEngine On/g' /etc/modsecurity/modsecurity.conf
RUN apt-get install -y wget \
    && wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.5.1-amd64.deb \
    && dpkg -i filebeat-7.5.1-amd64.deb \
    && a2enmod headers
EXPOSE 80 8080 8000 8888
COPY start.sh /
RUN chmod +x /start.sh 
COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY ports.conf /etc/apache2/ports.conf

CMD ["/start.sh"]








