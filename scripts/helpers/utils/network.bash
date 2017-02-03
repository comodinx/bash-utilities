#! bash/bash Completion support for Network commands.

# Functions
# ---------------------------------------------------------------------------------------

get_network_service_name() {
    local guid=`printf "open\nget State:/Network/Global/IPv4\nd.show" | scutil | grep "PrimaryService" | awk '{print $3}'`
    local name=`printf "open\nget Setup:/Network/Service/$guid\nd.show" | scutil | grep "UserDefinedName" | awk -F': ' '{print $2}'`
    echo $name
}

get_network_service_ssid() {
    local ssid=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep " SSID: " | awk '{print $2}'`
    echo $ssid
}

get_network_ip() {
    local ip=`ipconfig getifaddr en0`
    echo $ip
}

port_in_use() {
    ### Check arguments
    if [ "$1" = '-h' -o "$2" = '-h' ]
    then
        utils_help -n port_in_use  -d 'Check if port is available' -o '-d (?) Show more details indicate if command is unavailable and PID use this port. Default false'
        return 0
    fi

    local port=$(lsof -i tcp:$1)
    local pid=$(echo $port | grep PID | cut -d ' ' -f 11)
    local detailInformation='Unavailable'
    # Default is unavailable
    local isAvailable=1

    port=$(echo $port | grep PID | wc -l)

    if [ $port -eq 0 ]
    then
        detailInformation='Available'
        isAvailable=0
    else
        detailInformation="$detailInformation (PID: $pid)"
    fi

    if [ "$2" = '-d' ]
    then
        logtrace "$detailInformation"
    fi
    return $isAvailable
}
