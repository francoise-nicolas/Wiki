# `pieces_`

## Description

A vocation à être utilisé:
1. Hors-ligne ([`.gitignore`](../.gitignore) paramétré en conséquence)
2. Pour le traitement de nouveaux fichiers
3. En vue de leur transfert vers [`pieces`](../pieces)
4. Partout où il est dit « supprimer fichier(s) », cela vaut sauf les fichiers témoins ([ici](INBOX/vide-mais-necessaire) et [ici](OUTBOX/vide-mais-necessaire))

### Étape 1: Indexer fichiers

* Déposer fichiers dans [`INBOX`](INBOX)
* Exécuter:

```
find INBOX -type f -size +0 -print0 | xargs -0 -n1 "$SHELL" -c './indexer-fichier.sh "${1}"' "$SHELL"
```
( optionellement, `./indexer-fichier.sh` → `./indexer-fichier.sh --original` )

* Supprimer le contenu de [`INBOX`](INBOX)

### Étape 2: encryption en lot (optionnel)

* Déposer les dossiers créés à l'étape 1 dans [`INBOX`](INBOX) (redite)
* Éxecuter:
```
./encryptelot.sh
```

### Étape 3: encryption en lot (optionnel)

* Couper-coller le contenu de [`OUTBOX`](OUTBOX)  vers [`pieces`](../pieces)
