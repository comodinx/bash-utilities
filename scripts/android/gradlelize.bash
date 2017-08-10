#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
proyectName=''
baseGradleDirName=''


### Parse arguments
while getopts ":n:h" opt; do
    case "${opt}" in
        s)  proyectName=$OPTARG;;
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

if ! [ -z "$baseGradleDirName" ]
then
    baseGradleDirName="app"
fi

if ! [ -d "$proyectName/src"]
then
    logwarn "Directory ${proyectName} not contains a src folder"
    exit 1
fi

if [ -f "$proyectName/build.gradle"]
then
    logwarn "Directory ${proyectName} is an gradle proyect"
    exit 0
fi


### Source function
logdebug "1. Create new application module directory `app` in `${proyectName}`"
mkdir -p ${proyectName}/${baseGradleDirName}/src/main/java

logdebug "2. Move source codes to senz"
mv ${proyectName}/src/com ${proyectName}/${baseGradleDirName}/src/main/java

logdebug "3. Move res and asserts"
mv ${proyectName}/res ${proyectName}/${baseGradleDirName}/src/main
mv ${proyectName}/asserts ${proyectName}/${baseGradleDirName}/src/main  

logdebug "4. Move libs"
mv ${proyectName}/libs ${proyectName}/${baseGradleDirName}/

logdebug "5. Move AndroidManifest "
mv ${proyectName}/AndroidManifest.xml ${proyectName}/${baseGradleDirName}/src/main

logdebug "6. Create gradle build  files"
touch ${proyectName}/build.gradle
touch ${proyectName}/settings.gradle
touch ${proyectName}/senz/build.gradle

exit 0