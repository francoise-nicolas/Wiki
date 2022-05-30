#! /usr/bin/env bash
# ----------------------------------------------
# label.sh
# Copyright (2022) @lawfare
# GPL v3.0
# Repository: github.com/lawfare/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./label.sh"\
           "Regroupe les dossiers de pièces par label, par exemple, label_CAA Nantes". 
}

[[ $PWD =~ maintenance ]] || { echo "ERREUR: '$PWD' != 'maintenance'"; exit 1; }

symbolique=1
case ${1} in
    --help) help; exit 0;;
    --*) printf "ERREUR: option ${1} inconnue"; exit 1;
esac

cible_racine='../pieces/label'
find "${cible_racine}" -mindepth 1 |\
    grep -v "README.md" |\
    while IFS= read path;
    do
        rm "${path}";
    done

find ../pieces -mindepth 3 -type f -size 0 -name "label_*" |\
    while IFS= read label_valeur;
    do
        dossier=$(dirname "${label_valeur}")
        uid="${dossier##*/}"
        b=$(basename "${label_valeur}")
        valeur="${b/label_/}"
        cible="${cible_racine}"/"${valeur}".md
        touch "${cible}"
        printf "%s\n" "[${uid}](../pieces/identifiant/${uid})" >> "${cible}"
    done

exit 0
