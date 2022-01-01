#!/bin/bash
# IP4_4_XfcePanel V2.0
# written by Sebastian Giese 2021-2022

#Paramaeters:
# :adapter
# -l5: show local IP4
# -l7: show local IP6
# -g4: show global IP4
# -g6: show global IP6
# -hd: hide description
# -help: show help

# check (and set) networkadapter parameter (not needed for global IP)
Param=("$@")
adapter="missed"
i=0
for arg in "${Param[@]}"
do
    if [[ ${arg::1} == ":" ]]
    then
        adapter="${arg#?}"
        ifconfig $adapter >/dev/null 2>&1
        if [ $? != 0 ]
        then
            echo "$adapter - networkadpter not found"
            exit 1
        fi
    break
    fi
done

#Standartparameter defination
l4=0
l6=0
g4=0
g6=0
hd=0

while [ $# -gt 0 ]
do 
    if [ $1 == '-l4' ] && [ $adapter != "missed" ]
    then
        l4=$(ifconfig $adapter | grep inet |awk '{print $2}'  | head -n 1)
    elif [ $1 == '-l4' ] && [ $adapter == 'missed' ]
    then
        echo "$1 local IP requested, but now adapter specified; use -help to show valid Parameters"
        exit 1
    elif [ $1 == '-l6' ] && [ $adapter != "missed" ]
    then
        l6=$(ifconfig $adapter | grep inet6 |awk '{print $2}'  | head -n 1)
    elif [ $1 == '-l6' ] && [ $adapter == 'missed' ]
    then
        echo "$1 local IP requested, but no networkadapter specified; use -help to show valid Parameters"
        exit 1
    elif [ $1 == '-g4' ]
    then
        g4=$(curl -4 ifconfig.co) >/dev/null 2>&1
    elif [ $1 == '-g6' ] 
    then
        g6=$(curl -6 ifconfig.co) >/dev/null 2>&1
        if [ $g6=0 ]
        then
            g6="nog6"
        fi
    elif [ $1 == '-hd' ]
    then
        hd=1
    elif [ $1 == '-help' ]
    then
        echo -e "\nIP_4_XfcePanel - HELP"
        echo -e "\n:{networkadapter} (needed for local ip) i.e. :eth0, :wlan1"
        echo "-l4: show local IP (IP4 format)"
        echo "-l6: show local IP (IP6 format)"
        echo "-g4: show global IP (IP4 format)"
        echo "-g6: show global IP (IP6 format)"
        echo "-hd: hide description"
        echo "-help: show this help"
        exit 1
    else
    #prüfen ob es der Adapter ist
        check=$1
        if [[ ${check::1} != ":" ]]
        then
            echo -e "$check - unknown Parameter use -help for valid Parameters\nuse ':' for networkadapter"
            exit 1
        fi
    fi
    shift
done

#rem generate output string
if [ $l4 != "0" ]
then
    if [ $hd = 0 ]
    then
        output="LocalIP: "
    fi
        output=$output"<"$l4"> "
fi

if [ $l6 != "0" ]
then
    if [ $hd = 0 ]
    then
        output=$output"LocalIP: "
    fi
        output=$output"<"$l6"> "
fi

if [ $g4 != "0" ]
then
    if [ $hd = 0 ]
    then
        output=$output"GlobalIP: "
    fi
        output=$output"<"$g4"> "
fi

if [ $g6 != "0" ]
then
    if [ $hd = 0 ]
    then
        output=$output"GlobalIP: "
    fi
    if [ $g6 == "nog6" ]
    then
        output=$output"Global IP6 is not supported - check config or ask your provider for further information"
    else
        output=$output"<"$g6"> "
    fi
fi

echo $output