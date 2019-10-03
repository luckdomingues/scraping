#!/bin/bash

##
## script para LAB 03
##

function PrintUsage() {
    echo "Uso: `basename $0` <URL>"
    exit 1
}

function CapturaHTML() {
    html=$(wget $1 -O - 2> /dev/null)
}

function FiltraLinksExternos() {
    for x in $(echo $html)
    do
    #echo $x >> t.txt 
    if [ "$(echo $x | grep href)" != "" ]
    then
        echo $x >> tmp1.$$
    fi
    done

    url=$(cat tmp1.$$ | grep "\." | grep http | cut -d'"' -f2 | cut -d"/" -f3 | sort | uniq )
}

function ResolveURL() {
    n="1"
    for x in $(echo $url)
    do
        ip=$(host $x)

    if [ "$(echo $ip | grep address)" != ""  ]
    then
        echo "[$n]" - $x " - " $(echo $ip | cut -d" " -f4)
        n=$[$n+1]
    fi
    done
}
## == fim das Funcoes

### SCRIPT INICIA AQUI CHAMANDO AS FUNCOES

if [ "$1" = "" ]
then
    PrintUsage
fi

CapturaHTML $1
FiltraLinksExternos
ResolveURL
# apaga arquivo temporario
rm tmp1.$$

exit 0