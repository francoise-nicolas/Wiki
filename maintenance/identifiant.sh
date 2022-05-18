#! /usr/bin/env bash
# ----------------------------------------------
# identifiant.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/Wiki
# ----------------------------------------------

help()
{
    printf "%s\n %s %s "\
           "Usage: ./indexer.sh [--original] [cible] [fichier]"\
           "Ajoute à [cible] un dossier contenant une copie de [fichier], chacun nommé d'après un identifiant unique, "\
           "et un fichier vide nommé d'après le fichier original"
}

[[ $PWD =~ maintenance ]] || { echo "ERREUR: '$PWD' != 'maintenance'"; exit 1; }

renomme=0

case ${1} in
    --help) help; exit 0;;
    --original) renomme=1; shift;;
    --*) echo "ERREUR: ${1}, option non connue"; exit 1;;
esac

cible="${1}"
shift

[[ -d "${cible}" ]]  || { echo "ERREUR '${cible}' n'est pas un fichier"; exit 1; }

source="${1}"
shift
    
[[ -f "${source}" ]]  || { echo "ERREUR '${source}' n'est pas un fichier"; exit 1; }

[[ -s "${source}" ]]  || { echo "ERREUR '${source}' est vide"; exit 1; }

hex=$(cksum "$source" | awk '{ print $1 }' | xargs printf "%x")

dossier="${cible}"/"$hex"

echo "${dossier}"

mkdir -p "${dossier}"
touch "${dossier}"/label_??
basename=$(basename "${source}")
cible="${dossier}/"
if
    (( renomme == 0 ))
then
    cible+="${hex}"
    if
        [[ $basename =~ \..{1,5}$ ]]
    then
        ext="${basename##*.}"
    else
        ext="NOEXT"
    fi
    #    echo "$ext" # debug
    cible+=".${ext}"
else
    cible+="${basename}"
fi
cp "${source}" "${cible}"
printf "%s\n" "${cible}"
(( renomme == 0 )) && touch "${dossier}/original_${basename}"

# mv -f "${source}" TRASH

exit 0
