FROM fedora

RUN yum install -y pulseaudio
RUN yum groupinstall -y "Sugar Desktop Environment"
RUN adduser sugaruser
RUN echo "sugar\nsugar" | passwd --stdin root

CMD "/bin/bash"
