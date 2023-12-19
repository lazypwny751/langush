set -e

source $(command -v langush)
langush --build "en.sh" "tr.sh"

langush.gettext "en.lang" "hello"
langush.gettext "tr.lang" "hello"
