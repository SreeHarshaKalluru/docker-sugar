USER_UID=$(id -u)
USER_GID=$(id -g)

activity=""
if [ $# -eq 1 ]
then
    pwd=`pwd`
    activity_dir=$1
    folder=`basename $activity_dir`
    activity="--volume=$pwd/$activity_dir:/usr/share/sugar/activities/$folder"
fi

docker run -ti --rm \
       --privileged \
       -e DISPLAY \
       --env="USER_UID=${USER_UID}" \
       --env="USER_GID=${USER_GID}" \
       --ipc=host \
       --pid=host \
       --volume=/tmp/.X11-unix:/tmp/.X11-unix \
       --volume=/run/user/${USER_UID}/pulse:/run/pulse \
       $activity \
       mikkl/sugar \
       su sugaruser -c 'sugar-runner --resolution 800x600'
