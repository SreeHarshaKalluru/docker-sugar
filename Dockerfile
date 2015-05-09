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

#Patch for gtk glitches
RUN rm -rf /usr/lib/python2.7/site-packages/sugar
RUN ln -s /usr/lib/python2.7/site-packages/sugar3 /usr/lib/python2.7/site-packages/sugar

CMD "/bin/bash"
