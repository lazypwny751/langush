#!/bin/bash

set -e

if ! command -v "sdb" &> /dev/null ; then
    echo -e "sdb not found, please install it:\nsource: https://github.com/radareorg/sdb.git"
    exit 1
fi

locale.setloc() {
    if [[ -n "${1}" ]] ; then
        export SETLOC="${1}"
    fi
}

locale.push() {
	if [[ -n "${SETLOC}" ]] ; then
    	if [[ -n "${1}" ]] && [[ -n "${2}" ]] ; then
        	sdb "${SETLOC%%.*}.lang" "${1}"="${2}"
    	fi
	else
		echo "\$SETLOC not found, please firstly use \"locale.setloc <locale>\""
		return 1
	fi
}

langush.gettext() {
    if [[ -f "${1}" ]] ; then
        sdb "${1}" "${2}"
    fi
}

if [[ "${BASH_SOURCE[0]}" = "${0}" ]] ; then
	export OPT="help"
	while [[ "${#}" -gt 0 ]] ; do
		case "${1,,}" in
			("--build")
				export OPT="build"
				shift
			;;
			(*)
				export OPTARG+=("${1}")
				shift
			;;
		esac
	done

	case "${OPT}" in
		("build")
			for opt in "${OPTARG[@]}" ; do
				if [[ -f "${opt}" ]] ; then
					unset SETLOC
					source "${opt}"
				fi
			done
		;;
		("help")
			echo -e "${0##*/}: langush is a localization tool using sdb,\nusage: ${0##*/} --build en.sh tr.sh"
			exit 0
		;;
		(*)
			echo "${0##*/}: \"${OPT}\": unknown option."
			exit 1
		;;
	esac
fi

