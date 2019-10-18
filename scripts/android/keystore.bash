#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
proyectPath=''
name='debug'
keyAlg='RSA'
keySize='2048'
keyPass='android'
storePass='android'
aliasKeystore='androiddebugkey'
validity='10000'
dname='CN=Android Debug,O=Android,C=US'


### Parse arguments
while getopts ":d:n:a:s:p:P:A:v:N:h" opt; do
    case "${opt}" in
        d)  proyectPath=$OPTARG;;
        n)  name=$OPTARG;;
        a)  keyAlg=$OPTARG;;
        s)  keySize=$OPTARG;;
        p)  keyPass=$OPTARG;;
        P)  storePass=$OPTARG;;
        A)  aliasKeystore=$OPTARG;;
        v)  validity=$OPTARG;;
        N)  dname=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n android_keystore -a akeystore -d 'Create keystore' -o '-n Your proyect name. Default is your currect directory name.' -o '-d Your base gradle directory name. Default is "app"'
    exit 0
fi

if ! [ -z "$proyectPath" ]
then
    proyectPath='.'
fi

if ! [ -d "${proyectPath}/src" ]
then
    logwarn "Directory ${proyectPath} not contains a src folder"
    exit 1
fi


### Source function
logsuccess "Create ${name} keystore in module directory 'app' in '${proyectPath}'"
keytool -genkey -v -keystore "${proyectPath}/${name}.keystore" -alias "${aliasKeystore}" -storepass "${storePass}" -keypass "${keyPass}" -keyalg "${keyAlg}" -keysize "${keySize}" -validity "${validity}" -dname "${dname}"

exit 0
