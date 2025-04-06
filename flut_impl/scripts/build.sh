MAGENTA='\033[0;95m' # Bright Magenta
NC='\033[0m' # No Color

SECONDS=0

echo -e "${MAGENTA}building root...${NC}"
dart run build_runner build --delete-conflicting-outputs

duration=$SECONDS
echo -e "${MAGENTA}build done in $((duration / 60)) minutes and $((duration % 60)) seconds."