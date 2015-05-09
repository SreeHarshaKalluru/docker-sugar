USER_UID=$(id -u)
USER_GID=$(id -g)

docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       --env="USER_UID=${USER_UID}" \
       --env="USER_GID=${USER_GID}" \
       --volume=/tmp/.X11-unix:/tmp/.X11-unix \
       --volume=/run/user/${USER_UID}/pulse:/run/pulse \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       mikkl/sugar \
       /bin/bash
