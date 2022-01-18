FROM ubuntu
ENV USER=root
ENV PASSWORD=SHSopticslab
ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true
COPY MOO1 /dos/MOO1
RUN apt-get update && \
  echo "tzdata tzdata/Areas select America" > ~/tx.txt && \
  echo "tzdata tzdata/Zones/America select New York" >> ~/tx.txt && \
  debconf-set-selections ~/tx.txt && \
  apt-get install -y tightvncserver ratpoison dosbox novnc websockify && \
  mkdir ~/.vnc/ && \
  mkdir ~/.dosbox && \
  echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd && \
  chmod 0600 ~/.vnc/passwd && \
  echo "set border 0" > ~/.ratpoisonrc  && \
  echo "exec dosbox -conf ~/.dosbox/dosbox.conf -fullscreen -c 'MOUNT C: /dos'">> ~/.ratpoisonrc && \
  export DOSCONF=$(dosbox -printconf) && \
  cp $DOSCONF ~/.dosbox/dosbox.conf && \
  sed -i 's/usescancodes=true/usescancodes=false/' ~/.dosbox/dosbox.conf && \
  openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/novnc.pem -out ~/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com"
EXPOSE 80
CMD vncserver && websockify -D --web=/usr/share/novnc/ --cert=~/novnc.pem 80 localhost:5901 && tail -f /dev/null
