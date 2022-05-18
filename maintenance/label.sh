#! /usr/bin/env bash
# ----------------------------------------------
# label.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./pieces_label.sh"\
           "Regroupes les dossiers de pièces par label, par exemple, label_CAA Nantes". 
}

[[ $PWD =~ pieces_label ]] || { echo "ERREUR: '$PWD' != 'pieces_label'"; exit 1; }

symbolique=1
case ${1} in
    --help) help; exit 0;;
    --*) printf "ERREUR: option ${1} inconnue"; exit 1;
esac

label="${1}"
shift

[[ ${label} =~ label ]] || { echo "ERREUR: '$label' != 'label'"; exit 1; }

mkdir -p "${label}"

if
    [[ -d "${label}" ]]
then 
    [[ -z $(ls -A "${label}") ]] || rm -r "${label}"
fi

find ../pieces -mindepth 2 -maxdepth 2 -type f -size 0 -name "label_*" |\
    while IFS= read label_valeur;
    do
        dossier=$(dirname "${label_valeur}")
        dossier="${dossier##*/}"
#        echo "${dossier}"
#        b=$(basename "${label_valeur}")
#        code='valeur=$(echo "${b}" | sed '"'"'s/'"$label"'_//'"'"')'
#        eval "${code}"
#        cible="${label}/${valeur}"
#        mkdir -p "${label}"
#        cible+=".md"
#        touch "${cible}"
#        printf "%s\n" "[${dossier}](../../pieces/${dossier})" >> "${cible}"
    done

exit 0
