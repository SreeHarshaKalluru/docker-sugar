USER_UID=$(id -u)
USER_GID=$(id -g)

pwd=`pwd`
activities=""

if [ "$#" -eq 0 ]
then
    fvar="*"
    for f in $fvar
    do
        folder=`basename $f`
        if [[ "$folder" == *.activity ]]
        then
            fullpath=`readlink -f $f`
            activity="--volume=$fullpath:/usr/share/sugar/activities/$folder"
            activities=" $activities $activity"
        fi
    done
fi

for var in "$@"
do
    fvar="$var/*"
    for f in $fvar
    do
        folder=`basename $f`
        if [[ "$folder" == *.activity ]]
        then
            fullpath=`readlink -f $f`
            activity="--volume=$fullpath:/usr/share/sugar/activities/$folder"
            activities=" $activities $activity"
        fi
    done
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
