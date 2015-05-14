#!/bin/bash

USER_UID=$(id -u)
USER_GID=$(id -g)

pwd=`pwd`
SUGAR_RUNNER_PERSISTANCE=`pwd`/.sugar-runner
SUGAR_PERSISTANCE=`pwd`/.sugar
DISABLE_CURRENT_DIRECTORY=0
DISABLE_SUGAR_PERSISTANCE=0
DISABLE_SUGAR_RUNNER_PERSISTANCE=0
VOLUMES=""

while [[ $# > 0 ]]
do
    key="$1"
    case $key in
	--disable-current-directory)
	    DISABLE_CURRENT_DIRECTORY=1
	    ;;

	--disable-sugar-runner-persistance)
	    DISABLE_SUGAR_PERSISTANCE=1
	    ;;
	
	--disable-sugar-persistance)
	    DISABLE_SUGAR_RUNNER_PERSISTANCE=1
	    ;;
	--sugar-persistance)
	    SUGAR_PERSISTANCE=`readlink -f $2`
	    shift
	    ;;
	--sugar-runner-persistance)
	    SUGAR_RUNNER_PERSISTANCE=`readlink -f $2`
	    shift
	    ;;
	--activity)
	    ACTIVITIES[${#ACTIVITIES[@]}]=`readlink -f $2`
	    shift
	    ;;
	*)
	    ACTIVITIES[${#ACTIVITIES[@]}]=`readlink -f $1`
	    ;;
	
    esac
    shift
done

if [ "$DISABLE_CURRENT_DIRECTORY" -eq "0" ]
then
    ACTIVITIES[${#ACTIVITIES[@]}]=`pwd`
fi

for var in ${ACTIVITIES[*]}
do
    folder=`basename $var`
    activity="--volume=$var:/usr/share/sugar/activities/$folder"
    VOLUMES=" $VOLUMES $activity"
done

if [ "$DISABLE_SUGAR_PERSISTANCE" -eq "0" ]
then
    mkdir -p $SUGAR_PERSISTANCE

    folder=`basename $SUGAR_PERSISTANCE`
    persistance="--volume=$SUGAR_PERSISTANCE:/home/sugaruser/.sugar"
    VOLUMES=" $VOLUMES $persistance"
fi

if [ "$DISABLE_SUGAR_RUNNER_PERSISTANCE" -eq "0" ]
then
    mkdir -p $SUGAR_RUNNER_PERSISTANCE

    folder=`basename $SUGAR_RUNNER_PERSISTANCE`
    persistance="--volume=$SUGAR_RUNNER_PERSISTANCE:/home/sugaruser/.sugar-runner"
    VOLUMES=" $VOLUMES $persistance"
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
       $VOLUMES \
       mikkl/sugar \
       su sugaruser -c 'sugar-runner --resolution 800x600'
