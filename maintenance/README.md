# Maintenance

## Avertissement

Partout où il est dit « effacer »,  faire exception pour les fichiers `vide-conserver`.

## Identifiant

1. Dépôt dans `INBOX`, de fichiers destinés à être indexés 
2. Exécuter: 
   ```
   find INBOX -type f -size +0 -print0 | xargs -0 -n1 "$SHELL" -c './identifiant.sh OUTBOX "${1}"' "$SHELL"
   ```
3. optionellement, couper-coller les dossiers créés dans `INBOX`;
4. exécuter `crypter.sh`. Et enfin,
5. copier les dossiers de `OUTBOX` vers [`../pieces/identifiant`](../pieces/indentifiant)

## [Label](../pieces/label)
1. Exécuter `./label.sh`

## [Cite](../pieces/cite.md)
1. Exécuter `./cite.sh`

<!--

$ find pages -type f -name '*md' | while IFS= read path; do sed -i -E 's/\(corruption#([^)]+)\)/(.\/corruption.md#\1)/' "${path}"; done | grep 'lecoq2'

-->
