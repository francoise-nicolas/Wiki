# Maintenance

## Avertissement

Partout où il est dit « effacer »,  faire exception pour les fichiers `vide-conserver`.

## Identifiant

* objet: màj [`pieces/identifiant`](../pieces/identifiant)
* marche à suivre
    1. Dépôt dans `INBOX`, de fichiers destinés à être indexés 
    2. Exécuter: 
       ```
       find INBOX -type f -size +0 -print0 | xargs -0 -n1 "$SHELL" -c './identifiant.sh OUTBOX "${1}"' "$SHELL"
       ```
    3. optionellement, couper-coller les dossiers créés dans `INBOX`;
    4. exécuter `crypter.sh`. Et enfin,
    5. copier les dossiers de `OUTBOX` vers [`../pieces/identifiant`](../pieces/indentifiant)

## [Label](../pieces/label)
* objet: màj [`../pieces/label`](../pieces/label)
* marche à suivre:
    1. Exécuter `./label.sh`

## [Cite](../pieces/cite.md)
* objet: pour chaque identifiant, inventorier les pages de [`../pages`](../contenu) qui la citent
* marche à suivre:
    1. Exécuter `./cite.sh`
