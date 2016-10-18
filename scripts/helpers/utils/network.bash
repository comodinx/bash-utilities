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
