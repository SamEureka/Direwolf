#!/bin/sh

cd "$(dirname "$0")"


# makes things easier if script needs debugging
if [ x$FTB_VERBOSE = xyes ]; then
    set -x
fi

# cleaner code
eula_false() {
    grep -q 'eula=false' eula.txt
    return $?
}



# run install script if MC server or launchwrapper s missing
if [ ! -f minecraft_server.1.7.10.jar ]; then
    echo "Missing required jars. Running install script!"
    sh ./FTBInstall.sh
fi

# check if there is eula.txt and if it has correct content
if [ -f eula.txt ] && eula_false ; then
    echo "Make sure to read eula.txt before playing!"
    echo "To exit press <enter>"
    read ignored
    exit
fi

# inform user if eula.txt not found
if [ ! -f eula.txt ]; then
    echo "Missing eula.txt. Startup will fail and eula.txt will be created"
    echo "Make sure to read eula.txt before playing!"
    echo "To continue press <enter>"
    read ignored
fi

echo "Starting server"
#java -server -Xmx1024m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -jar FTBServer-1.7.10-1395.jar nogui
java -Xmx1024m -jar FTBServer-1.7.10-1395.jar nogui
echo "Server process finished"
