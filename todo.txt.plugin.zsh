alias todo='todo.sh'
alias todoa='todo add'
alias todod='todo do'
alias todol='todo list'
alias todolp='todo listproj'
alias todop='todo pri'
alias todoar='todo archive'

# Expand multiple lines removal
todor() {
	local pattern="[[:digit:] ]##"
	setopt extendedglob # Enable extended regexes
	setopt localoptions
	case $* in
		$~pattern)
			for number in $*; do
				todo rm $number
			done
			;;
		\*)
		    for number in $(todol |
		                    sed $'s/\e\[[0-9;:]*[a-zA-Z]//g' |  # Remove color from list output
		                    sed 's/^[^0-9].*//' |               # Remove non-task lines
		                    sed -r 's/^([0-9]+).*/\1/'          # Only keep the number in task's lines
		                    ); do
		        todo rm $number
		    done
		    ;;
		*)
	        echo '\e[1;31mWrong parameter : \e[0;31m'$*'\e[0m'
			echo 'Usage: todor NUMBERS'
			echo '\e[1mNUMBERS:\e[0m'
			echo '  Space-separated line numbers to delete (ex: 1 5 6)'
			echo '  \e[2mBrace expansion can also be used for adjacent NUMBERS, like : {5..7}'
			echo '  \e[2mWildcard character (*, beware of expansion, rather "quote" or \\escape it)'
			echo '    is also supported to deleted every line.'
			;;
	esac
}

# Print a reminder about todo.txt's syntax
todostx() {
    echo -e "$(
        cat <<-TodoTxtSyntax
			\e[1;32m╭────────────────────────────────── Syntaxe de todo.txt ──────────────────────────────────╮\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m Principe de base :                                                                      \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[1;3m1 ligne = 1 tâche\e[0m                                                                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m Le format des tâches est libre, néanmoins plusieurs \e[1mnotations\e[0m permettent de les         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m structurer :                                                                            \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┏ \e[1;2mMarque de complétion\e[0;1;33m*\e[0m (pour les tâche \e[1;33mcomplétées\e[0m, toujours en premier)               \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  Format : \e[1;2mx␣\e[0m                                                                          \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃                                                                                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┏ \e[1;31mPriorité\e[33m*\e[0m (pour les tâche \e[1;33mnon complétées\e[0m, toujours en premier)                    \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃  Format : \e[1;31m(\e[0m[\e[1;31mA-Z\e[0m]\e[1;31m␣)                                                                 \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃                                                                                    \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┏ \e[2;38;5;172mDate de complétion\e[0;1;33m*\e[0m (pour les tâche \e[1;33mcomplétées\e[0m, toujours après le \e[2mx\e[0m ;      \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃  si présente, la date de création doit aussi l'être)                        \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃  Format : (\e[2;38;5;172m20\e[0m|\e[2;38;5;172m19\e[0m)[\e[2;38;5;172m00-99\e[0m]\e[2;38;5;172m-\e[0m[\e[2;38;5;172m00-12\e[0m]\e[2;38;5;172m-\e[0m[\e[2;38;5;172m00-31\e[0m]\e[2;38;5;172m␣\e[0m                                   \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃                                                                             \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┏ \e[2;38;5;172mDate de création\e[0;1;33m*\e[0m                                              \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┃  Format : Idem date de complétion                               \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┃                                                                 \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┃                       ┏ \e[1mDescription de la tâche\e[0m, peut inclure  \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┃                       ┃  diverse étiquettes (projet, contexte,  \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┃  ┃      ┃           ┃                       ┃  clé:valeur)                            \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m ┻ ━┻━ ━━━━┻━━━━━ ━━━━━┻━━━━ ━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[1;2mx\e[0;1m \e[31m(A) \e[0;2;38;5;172m2012-12-21 2000-09-05\e[0;1;31m Live in \e[38;5;112m+peace\e[31m on \e[38;5;13m@Earth\e[31m \e[3;38;5;12mdue:eternity                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                     ━━┳━━━    ━━┳━━━ ━━━━━┳━━━━━━                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┃         ┗ \e[1mÉtiquette \e[3;38;5;12mclé:valeur\e[0;1;33m*\e[0m,     \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┃            pour renseigner des        \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┃            types de métadonnée        \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┃            supplémentaires            \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┃                                       \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃         ┗ \e[1mÉtiquette de \e[3;38;5;13mcontexte\e[0;1;33m*\e[0m, précédée     \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃            d'un espace, n'en contenant pas et   \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃            indiquée par un \e[1;3;38;5;13m@\e[0m, une tâche peut    \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃            faire partie de plusieurs contextes  \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┃                                                 \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                       ┗ \e[1mÉtiquette de \e[3;38;5;112mprojet\e[0;1;33m*\e[0m, précédée d'un espace,    \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                          n'en contenant pas et indiquée par un \e[1;3;38;5;112m+\e[0m, une   \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                          tâche peut faire partie de plusieurs projets   \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[2;3mLes champs marqués d'un \e[0;1;33m*\e[0;2;3m sont optionnels, on peut choisir ou non de les                \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[2;3minclure, mais si on le fait, \e[1mla syntaxe de leur format doit être respectée\e[0;2;3m.             \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[2;3mNote : L'exemple proposé n'est pas valide, puisqu'il cumule la marque de complétion     \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[2;3met la priorité.                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[2;3mDeux exemples valides, une tâche non complétée et une complétée, seraient :\e[0m             \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[1;31m(A) \e[0;2;38;5;172m2000-09-05\e[0;1;31m Live in \e[38;5;112m+peace\e[31m on \e[38;5;13m@Earth\e[31m \e[3;38;5;12mdue:eternity                                    \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m \e[1;2mx\e[0;1m \e[0;2;38;5;172m2012-12-21 2000-09-05\e[0;1;31m Live in \e[38;5;112m+peace\e[31m on \e[38;5;13m@Earth\e[31m \e[3;38;5;12mdue:eternity                           \e[0;1;32m│\e[0m
			\e[1;32m│\e[0m                                                                                         \e[0;1;32m│\e[0m
			\e[1;32m╰─────────────────────────────────────────────────────────────────────────────────────────╯\e[0m

		TodoTxtSyntax
	)" | ${PAGER:-less}
}
