#! /usr/bin/env bash
# ----------------------------------------------
# indexer-fichier.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./indexer-fichier.sh [--original] [fichier]"\
           "1. associe à [fichier] un identifiant unique (IU);"\
           "2. créé un dossier dans OUTBOX nommé (la valeur de) IU;"\
           "3. copie le fichier dans ce dossier;"\
           "4. par défaut renomme son nom avec UI et crée un fichier vide avec le nom original."
}

[[ $PWD =~ pieces ]] || { echo "ERREUR: '$PWD' != 'pieces_'"; exit 1; }

renomme=0

case ${1} in
    --help) help; exit 0;;
    --original) renomme=1; shift;;
    --*) echo "ERREUR: ${1}, option non connue"; exit 1;;
esac

source="${1}"
shift

[[ -f "${source}" ]]  || { echo "ERREUR '${source}' n'est pas un fichier"; exit 1; }
    
hex=$(cksum "$source" | awk '{ print $1 }' | xargs printf "%x")

cible_dossier=OUTBOX/"$hex"
mkdir -p "${cible_dossier}"
cible="${cible_dossier}/"
touch "${cible}"{qui_??,sujet_??}
basename=$(basename "${source}")
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
    echo "$ext" # debug
    cible+=".${ext}"
else
    cible+="${basename}"
fi
cp "${source}" "${cible}"
printf "%s\n" "${cible}"
(( renomme == 0 )) && touch "${cible_dossier}/${basename}"
# mv -f "${source}" TRASH

exit 0
