#! /usr/bin/env bash
# ----------------------------------------------
# classer.sh
# Copyright (2022) Françoise Nicolas
# GPL v3.0
# Repository: github.com/francoise-nicolas/wiki
# ----------------------------------------------

help()
{
    printf "%s\n"\
           "Usage: ./classer.sh --symbolique [classe]"\
           "1. Crée un dossier [classe];"\
           "2. Pour chaque dossier de `../pieces` correspondant à '[classe]_*',"\
           "crée un lien dans un sous-dossier ou dans une page, par défaut de type markdown."
}

[[ $PWD =~ _pieces ]] || { echo "ERREUR: '$PWD' != 'pieces_'"; exit 1; }

symbolique=1
case ${1} in
    --help) help; exit 0;;
    --symbolique) symbolique=0; shift;;
    --*) printf "ERREUR: option ${1} inconnue"; exit 1;
esac

classe="${1}"
shift

[[ ${classe} =~ qui|sujet ]] || { echo "ERREUR: '$class' != 'qui|sujet'"; exit 1; }

mkdir -p "${classe}"

if
    [[ -d "${classe}" ]]
then 
    [[ -z $(ls -A "${classe}") ]] || rm -r "${classe}"
fi

find ../pieces -mindepth 2 -maxdepth 2 -type f -size 0 -name "${classe}_*" |\
    while IFS= read classe_valeur;
    do
        dossier=$(dirname "${classe_valeur}")
        dossier="${dossier##*/}"
        echo "${dossier}"
        b=$(basename "${classe_valeur}")
        code='valeur=$(echo "${b}" | sed '"'"'s/'"$classe"'_//'"'"')'
        eval "${code}"
               cible="${classe}/${valeur}"
        if (( symbolique == 0 ))
           then
               lien_nom=$(echo "${d}" | xargs -n1 readlink --canonicalize)
               mkdir -p "${cible}"
               ln -s -t "${cible}" "${lien_nom}"
        else
            mkdir -p "${classe}"
            cible+=".md"
            touch "${cible}"
            printf "%s\n" "[${dossier}](../../pieces/${dossier})" >> "${cible}"
        fi
    done

exit 0
