USER_UID=$(id -u)
USER_GID=$(id -g)

pwd=`pwd`
activities=""
for var in "$@"
do
    folder=`basename $var`
    activity="--volume=$pwd/$var:/usr/share/sugar/activities/$folder"
    activities=" $activities $activity"
done


docker run -ti --rm \
       --privileged \
       -e DISPLAY \
       --env="USER_UID=${USER_UID}" \
       --env="USER_GID=${USER_GID}" \
       --ipc=host \
       --pid=host \
       --volume=/tmp/.X11-unix:/tmp/.X11-unix \
       --volume=/run/user/${USER_UID}/pulse:/run/pulse \
       $activities \
       mikkl/sugar \
       su sugaruser -c 'sugar-runner --resolution 800x600'
