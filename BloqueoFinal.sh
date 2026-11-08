#!/usr/bin/env bash
# Classroom Network Control - Public Demonstration
# Adapted from an internship project at IES Los Albares.
# This public edition never changes firewall rules: it generates a reviewable plan.
# No institutional addresses, credentials or internal topology are included.
set -euo pipefail

usage() {
  cat <<'HELP'
Usage: ./BloqueoFinal.sh --classroom NAME --action enable|disable [--domains FILE]

This public edition is DRY-RUN ONLY: it prints an example firewall plan.
It does not connect to any server or execute iptables.

Examples:
  ./BloqueoFinal.sh --classroom Demo-A --action enable --domains dominios_ejemplo.txt
  ./BloqueoFinal.sh --classroom Demo-A --action disable
HELP
}

CLASSROOM=''
ACTION=''
DOMAINS_FILE=''
while (($#)); do
  case "$1" in
    --classroom|--action|--domains)
      key=$1
      if (($# < 2)); then echo "Missing value for $key" >&2; exit 2; fi
      case "$key" in
        --classroom) CLASSROOM=$2 ;;
        --action) ACTION=$2 ;;
        --domains) DOMAINS_FILE=$2 ;;
      esac
      shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ -n "$CLASSROOM" && "$CLASSROOM" =~ ^[a-zA-Z0-9_-]+$ ]] || { echo 'Invalid or missing classroom label' >&2; exit 2; }
[[ "$ACTION" == enable || "$ACTION" == disable ]] || { echo 'Action must be enable or disable' >&2; exit 2; }

printf 'Classroom: %s\nMode: %s\nExecution: SIMULATION ONLY\n\n' "$CLASSROOM" "$ACTION"
if [[ "$ACTION" == disable ]]; then
  cat <<'PLAN'
Illustrative restoration plan:
  - Confirm current firewall policy and take a backup.
  - Restore the previously saved known-good ruleset.
  - Verify connectivity from an authorized test machine.
No commands have been executed.
PLAN
  exit 0
fi

[[ -n "$DOMAINS_FILE" && -f "$DOMAINS_FILE" && -r "$DOMAINS_FILE" ]] || {
  echo 'For enable, provide a readable --domains file' >&2; exit 2;
}

# This example accepts simple hostnames only; no arbitrary shell input.
# Note: resolving a hostname to an IP is NOT equivalent to reliable website allowlisting.
count=0
while IFS= read -r line || [[ -n "$line" ]]; do
  line=${line%%#*}
  line=${line//$'\r'/}
  line=${line//[[:space:]]/}
  [[ -z "$line" ]] && continue
  if [[ ! "$line" =~ ^[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?$ ]] || [[ "$line" == *..* ]]; then
    printf 'Invalid hostname: %s\n' "$line" >&2
    exit 2
  fi
  printf 'Requested allowed hostname: %s\n' "$line"
  ((count+=1))
done < "$DOMAINS_FILE"
((count > 0)) || { echo 'No valid hostnames found' >&2; exit 2; }
cat <<'PLAN'

Illustrative deployment plan (not executed):
  1. Authenticate to the authorized classroom gateway.
  2. Back up its current firewall rules and confirm rollback access.
  3. Resolve and validate necessary services, dependencies and DNS.
  4. Apply a reviewed, platform-specific ruleset atomically.
  5. Test allowed and blocked traffic, including IPv6 and existing sessions.
  6. Restore the exact previous ruleset when exam mode ends.

IMPORTANT: IP-based firewall rules cannot guarantee domain-level filtering.
Shared IPs, CDNs, changing DNS records, and encrypted traffic require
additional policy design. This file is a portfolio demonstration, not a
production firewall deployment tool.
PLAN
