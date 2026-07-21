#!/usr/bin/env bash
#
# Spustí VŠECHNY importní Apex skripty CERMAT do zvoleného Salesforce orgu
# jedním příkazem, přes Salesforce CLI (sf / sfdx). Každý soubor je samostatný
# anonymní Apex (vlastní třída C), proto se spouští jeden po druhém – nejde je
# slepit do jednoho běhu. Skripty jsou idempotentní, takže se dají spouštět
# opakovaně bez duplicit (úloha, jejíž Name už existuje, se přeskočí).
#
# Použití:
#   scripts/apex/run-all.sh <alias-nebo-username-orgu>
#
# Příklad:
#   sf org login web --alias gomath          # jednorázové přihlášení
#   scripts/apex/run-all.sh gomath
#
# Předpoklad: v orgu už jednou proběhl seed-taxonomy.apex (naplní taxonomii).
# Máte-li ho po ruce, spusťte ho jako první:
#   sf apex run --file cesta/seed-taxonomy.apex --target-org gomath

set -u
ORG="${1:-}"
if [[ -z "$ORG" ]]; then
  echo "Použití: $0 <alias-nebo-username-orgu>" >&2
  exit 2
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

# Zjisti, které CLI je k dispozici (nové 'sf' vs. starší 'sfdx').
if command -v sf >/dev/null 2>&1; then
  run_apex() { sf apex run --file "$1" --target-org "$ORG"; }
elif command -v sfdx >/dev/null 2>&1; then
  run_apex() { sfdx force:apex:execute --apexcodefile "$1" --targetusername "$ORG"; }
else
  echo "Nenašel jsem 'sf' ani 'sfdx'. Nainstaluj Salesforce CLI: https://developer.salesforce.com/tools/salesforcecli" >&2
  exit 3
fi

shopt -s nullglob
FILES=("$DIR"/import-cermat-*.apex)
TOTAL=${#FILES[@]}
if [[ $TOTAL -eq 0 ]]; then
  echo "Nenašel jsem žádné soubory import-cermat-*.apex v $DIR" >&2
  exit 4
fi

echo "Spouštím $TOTAL částí do orgu '$ORG'…"
i=0
FAIL=()
for f in "${FILES[@]}"; do
  i=$((i+1))
  name="$(basename "$f")"
  printf '[%3d/%3d] %s … ' "$i" "$TOTAL" "$name"
  if run_apex "$f" >/tmp/apex_out.$$ 2>&1; then
    echo "OK"
  else
    echo "CHYBA"
    FAIL+=("$name")
    sed 's/^/    /' /tmp/apex_out.$$ | tail -8
  fi
done
rm -f /tmp/apex_out.$$

echo
if [[ ${#FAIL[@]} -eq 0 ]]; then
  echo "Hotovo: všech $TOTAL částí proběhlo úspěšně."
else
  echo "Hotovo s chybami (${#FAIL[@]} z $TOTAL):"
  printf '  - %s\n' "${FAIL[@]}"
  echo "Skripty jsou idempotentní – po opravě příčiny stačí skript spustit znovu,"
  echo "už založené úlohy se přeskočí."
  exit 1
fi
