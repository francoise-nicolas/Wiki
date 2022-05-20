#! /usr/bin/env bash
# ----------------------------------------------
# entravaux.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/Wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./entravaux.sh"\
           "1. Met à jour '../pages/entravaux.md'."
}

case ${1} in
    --help) help; exit 0;;
    --*) echo "ERREUR: ${1}, option non connue"; exit 1;;
esac


[[ $PWD =~ maintenance ]] || { echo "ERREUR: '$PWD' != 'maintenance'"; exit 1; }

source='../pages'
cible="${source}"/'entravaux.md'

touch "${cible}"
>"${cible}"
printf "%s\n"\
       "# En travaux"\
       "## Description"\
       "Dresse l'inventaire des pages contenant '🚧'"\
       "## Pages"\
>> "${cible}"

while IFS=$'\n' read line;
do
    
    grep -nH '🚧' "${line}" | sed -r 's/^(.+?):.+$/\1/'
    
done < <(find "${source}" -type f -name '*md' | grep -v "${cible}")

exit 0
