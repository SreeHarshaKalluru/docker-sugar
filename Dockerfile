FROM fedora

#Sound support
RUN yum install -y pulseaudio

#Install env
RUN yum groupinstall -y "Sugar Desktop Environment"

#User
RUN adduser sugaruser

#Setting password
RUN echo "sugar" | passwd --stdin root
RUN echo "sugar" | passwd --stdin sugaruser

RUN yum install -y sugar-runner

RUN mkdir /var/run/dbus

CMD "/bin/bash"
