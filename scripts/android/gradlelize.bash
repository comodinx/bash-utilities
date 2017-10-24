#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
proyectName=''
baseGradleDirName=''


### Parse arguments
while getopts ":n:d:h" opt; do
    case "${opt}" in
        n)  proyectName=$OPTARG;;
        d)  baseGradleDirName=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n android_gradlelize -a agradlelize -d 'Transform your current proyect in a gradle proyect' -o '-n Your proyect name. Default is your currect directory name.' -o '-d Your base gradle directory name. Default is "app"'
    exit 0
fi

if ! [ -z "$proyectName" ]
then
    proyectName=${PWD##*/}
    cd ..
fi

if [ -z "$baseGradleDirName" ]
then
    baseGradleDirName="app"
fi

if ! [ -d "${proyectName}/src" ]
then
    logwarn "Directory ${proyectName} not contains a src folder"
    exit 1
fi

if [ -e $proyectName/build.gradle ]
then
    logwarn "Directory ${proyectName} is an gradle proyect"
    exit 0
fi


### Source function
logsuccess "Create new application module directory 'app' in '${proyectName}'"
mkdir -p ${proyectName}/${baseGradleDirName}/src/main/java

logsuccess "Move source codes to ${baseGradleDirName}"
mv ${proyectName}/src/com ${proyectName}/${baseGradleDirName}/src/main/java

logsuccess "Move res and assets/asserts"
mv ${proyectName}/res ${proyectName}/${baseGradleDirName}/src/main

if [ -d "${proyectName}/assets" ]
then
    mv ${proyectName}/assets ${proyectName}/${baseGradleDirName}/src/main  
fi
if [ -d "${proyectName}/asserts" ]
then
    mv ${proyectName}/asserts ${proyectName}/${baseGradleDirName}/src/main  
fi

if [ -d "${proyectName}/libs" ]
then
    logsuccess "Move libs."
    mv ${proyectName}/libs ${proyectName}/${baseGradleDirName}/
fi

logsuccess "Move AndroidManifest "
mv ${proyectName}/AndroidManifest.xml ${proyectName}/${baseGradleDirName}/src/main

logsuccess "Create gradle build files"
touch ${proyectName}/build.gradle
touch ${proyectName}/settings.gradle
touch ${proyectName}/${baseGradleDirName}/build.gradle

exit 0
