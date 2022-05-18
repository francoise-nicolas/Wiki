# Maintenance

## Avertissement

Partout où il est dit « effacer »,  faire exception pour les fichiers nommés `vide-conserver`.

## MÀJ de [`../pieces/identifiant`](../pieces/identifiant)

1. Effacer le contenu de `INBOX`
2. Dépôt dans `INBOX`, de fichiers destinés à être indexés 
3. Exécuter: 

```
find INBOX -type f -size +0 -print0 | xargs -0 -n1 "$SHELL" -c './indentifiant.sh OUTBOX "${1}"' "$SHELL"
```

À ce stade, les dossiers obtenus dans `OUTBOX` sont prêts à être copiés dans `identifiant`. 
Toutefois, l'on peut préférer crypter les fichiers qu'ils contiennent, comme suit:

4. Effacer le contenu de `INBOX`
5. Couper-coller les dossier de `OUTBOX` dans `INBOX`
6. Exécuter `crypter.sh`

## MÀJ de [`../pieces/label`](../pieces/label)

1. Exécuter `./label.sh`

## MÀJ de [`../pieces/cite.md`](../pieces/cite.md)

1. Exécuter `./cite.sh`

## Travaux en cours

### Signalitique: 🚧

### Recherche

```
find . -type f -name '*md' -print0 | xargs -0 -n1 grep -H '🚧'
```
