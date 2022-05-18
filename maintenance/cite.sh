#! /usr/bin/env bash
# ----------------------------------------------
# cite.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./cite.sh" \
           "1. MAJ ../pieces/identifiant/*/cite.md"
}

case ${1} in
    --help) help; exit 0;;
    --*) echo "ERREUR: ${1}, option non connue"; exit 1;;
esac

cible_racine='../pieces/identifiant'

find "${cible_racine}" -type f -name '*md' -print0\
    | grep -vz -e 'README.md' \
    | tr "\n" "\0"\
    | xargs -0 -rn1 "$SHELL"\
          -c '[[ ${1} =~ cite\.md ]] && rm ${1}  || echo "ATTENTION: ${1} != cite.md; ignoré"'\
          "$SHELL"

# Ou sinon:
#find ../pieces -type f -name 'cible.md' -exec rm {} \;

    find ../composition -type f -size +0 -name '*md' | \
    while IFS= read -r chem;
    do
        matches=$(grep -E 'pieces/identifiant/[0-9a-z]+' "${chem}" | sort | uniq)
        chem='../'"${chem}"
        [[ -z "${matches}" ]] || 
            while IFS= read -r match;
            do
                iu=$(echo "${match}" | sed -E 's/.*pieces\/identifiant\/([0-9a-z]+).*/\1/')
                cible="../pieces/identifiant/${iu}/cite.md"
                touch "${cible}"
                printf "%s\n" "[${chem}](${chem})" >> "${cible}"
            done <<< "${matches}"
    done 

exit 0
