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
Si en plus on veut encrypter ces fichiers, 
    3. couper-coller les dossiers créés dans `INBOX`
    4. Exécuter `crypter.sh`
Et enfin,
    5. copier les dossiers de `OUTBOX` vers [`../pieces/indentifiant`](../pieces/indentifiant)

## [Label](../pieces/label)
    * objet: regrouper les identifiants par label
    * marche à suivre:
        1. Exécuter `./label.sh`

## [Cite](../pieces/cite.md)
* objet: pour chaque pièce, inventorier les pages de [`../contenu`](../contenu) qui la citent
* marche à suivre:
    1. Exécuter `./cite.sh`

## Travaux en cours

* Signalitique: 🚧
* Recherche
```
find . -type f -name '*md' -print0 | xargs -0 -n1 grep -H '🚧'
```
