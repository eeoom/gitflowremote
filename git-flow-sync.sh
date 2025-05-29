#!/bin/bash

# Git Flow Sync Tool v2.1
# Supports: start, finish, cleanup

set -e

ACTION=""
TYPE=""
NAME=""
DRYRUN=0
VERBOSE=0
FORCE_CLEAN=0

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_usage() {
  echo "Usage:"
  echo "  $0 [--dry-run] [--verbose] <start|finish|cleanup> <type?> <name?>"
  echo ""
  echo "Examples:"
  echo "  $0 start feature login-ui"
  echo "  $0 finish feature login-ui --verbose"
  echo "  $0 cleanup"
}

log() {
  [[ $VERBOSE -eq 1 ]] && echo -e "${YELLOW}[LOG]${NC} $1"
}

run() {
  if [[ $DRYRUN -eq 1 ]]; then
    echo -e "${YELLOW}[DRY RUN]${NC} $1"
  else
    eval "$1"
  fi
}

# Parse args
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run) DRYRUN=1; shift ;;
    --verbose) VERBOSE=1; shift ;;
    --force) FORCE_CLEAN=1; shift ;;
    start|finish|cleanup) ACTION=$1; shift ;;
    feature|release|hotfix) TYPE=$1; shift ;;
    *) [[ -z "$NAME" ]] && NAME=$1 && shift || { echo -e "${RED}Unknown arg: $1${NC}"; exit 1; } ;;
  esac
done

# ========== CLEANUP ACTION ==========
if [[ "$ACTION" == "cleanup" ]]; then
  echo -e "${GREEN}🧹 Running cleanup...${NC}"
  run "git fetch --prune"

  log "Checking for local branches tracking deleted remote branches..."
  STALE_BRANCHES=$(git branch -vv | awk '/\[gone\]/ {print $1}')

  if [[ -z "$STALE_BRANCHES" ]]; then
    echo -e "${GREEN}✅ No stale branches found.${NC}"
    exit 0
  fi

  echo -e "${YELLOW}Found stale local branches tracking deleted remotes:${NC}"
  echo "$STALE_BRANCHES"

  if [[ $DRYRUN -eq 1 ]]; then
    echo -e "${YELLOW}[DRY RUN] Would delete:${NC}"
    echo "$STALE_BRANCHES"
    exit 0
  fi

  if [[ $FORCE_CLEAN -eq 1 ]]; then
    echo -e "${GREEN}🗑 Deleting without prompt (--force)...${NC}"
    echo "$STALE_BRANCHES" | xargs -r git branch -d
  else
    echo ""
    read -p "Do you want to delete these local branches? [y/N] " CONFIRM
    if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
      echo "$STALE_BRANCHES" | xargs -r git branch -d
      echo -e "${GREEN}🧼 Cleanup complete.${NC}"
    else
      echo -e "${YELLOW}Skipped branch deletion.${NC}"
    fi
  fi

  exit 0
fi

# ========== START / FINISH ==========
if [[ -z "$ACTION" || -z "$TYPE" || -z "$NAME" ]]; then
  echo -e "${RED}Missing required arguments.${NC}"
  print_usage
  exit 1
fi

run "git fetch --prune"

case "$ACTION" in
  start)
    echo -e "${GREEN}🚀 Starting $TYPE/$NAME...${NC}"
    run "git flow $TYPE start $NAME"
    run "git push -u origin $TYPE/$NAME"
    ;;

  finish)
    echo -e "${GREEN}✅ Finishing $TYPE/$NAME...${NC}"
    run "git flow $TYPE finish $NAME"

    BASE_BRANCH="main"
    [[ "$TYPE" == "feature" ]] && BASE_BRANCH="develop"

    echo -e "${GREEN}📤 Pushing $BASE_BRANCH and tags...${NC}"
    run "git push origin $BASE_BRANCH --follow-tags"

    echo -e "${GREEN}🧹 Deleting remote $TYPE/$NAME branch...${NC}"
    run "git push origin :$TYPE/$NAME"
    ;;

  *)
    echo -e "${RED}Unknown action: $ACTION${NC}"
    print_usage
    exit 1
    ;;
esac

echo -e "${GREEN}✨ All done!${NC}"
