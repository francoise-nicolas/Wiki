#! /usr/bin/env bash
# ----------------------------------------------
# crypter.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./crypter.sh"\
           "1. Demande un mdp;"\
           "2. Descend dans l'arborescence de 'INBOX';"\
           "3. Copie dans OUTBOX les dossiers contenant un fichier non vide;"\
           "4. Remplace tout fichier non vide par une archive encryptée (zip)."
}

case ${1} in
    --help) help; exit 0;;
    --*) echo "ERREUR: ${1}, option non connue"; exit 1;;
esac


[[ $PWD =~ maintenance ]] || { echo "ERREUR: '$PWD' != 'maintenance'"; exit 1; }

printf "%s " \
"" \
"ATTENTION: l'étape à suivre affiche le mdp," \
"et désactive l'historique." \
"Entrer le mpd:"

HISTFILE=/dev/null

mdp=''
while IFS= read -r -n1 char
do
    mdp+="${char}"
    [[ "$char" == "" ]] && break
done

cp -r -t OUTBOX INBOX/* 

find OUTBOX -type f -size +0\
    | while IFS= read chemin;
do
    zip -jvmP "${mdp}" "${chemin}.zip" "${chemin}"
done

history | grep -q "${mdp}"

if
    (( $? == 0 ))
then
    printf "%s "\
           "ATTENTION: le mdp apparaît dans l'historique;" \
           "dans l'immédiat: 'history -c';" \
           "ensuite: corriger le bug."
    echo
fi

printf "%s "\
       "CONTRÔLE: OUTBOX conforme aux attentes? " \
       "Alors supprimer le contenu de INBOX."

echo

exit 0
