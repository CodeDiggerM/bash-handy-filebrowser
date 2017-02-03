 #!/bin/bash
#Array for storing history of file browse path. 
path_history=()
#Clear the cachs of screen.

export HISTORY=`pwd`
alias cl="clear && printf '\e[3J'"
#Go to the parent directory
alias u="cd ../"

#Override command 'CD'
function cd() {
	if builtin cd "$@"; then
		realpath=`pwd`;
    	IFS=' ' read -r -a array <<< "$HISTORY"
        for ((i=0; i < ${#array[@]} - 1; i++))
		do
            if [ ${array[$i]} = $realpath ]; then
                export HISTORY=""
                for (( j=0; j <= $i; j++))
                do
                    export HISTORY+=" $(pwd ${array[$j]})";
                done
                return
            fi
		done
        export HISTORY+=" $realpath"
	fi 
}

#Forward
function f(){
   	IFS=' ' read -r -a array <<< "$HISTORY"
	realpath=`pwd`
   	for ((i=0; i < ${#array[@]}; i++))
	do
        if [ ${array[$i]} = $realpath ] && (( $i < ${#array[@]} - 1 )); then
            builtin cd "${array[$i + 1]}"
			return
        fi
    done
}

#Backward
function b(){
   	IFS=' ' read -r -a array <<< "$HISTORY"
	realpath=`pwd`
   	for ((i=0; i < ${#array[@]}; i++))
	do
        if [ ${array[$i]} = $realpath ] && (( $i > 0 )); then
            builtin cd ${array[$i - 1]}
			return 
        fi
    done
}


#Backward
function p(){
   	IFS=' ' read -r -a array <<< "$HISTORY";
	if [[ $@ =~ ^[0-9]+$ ]]; then
		if (( ${#array[$@ - 1]} )); then
			builtin cd ${array[$@ - 1]};
		else
			echo "This index is out of range!"
		fi
	else
		echo "*#*#*#*#*#**#*#**#*#**#**#**#*#**#"
   		for ((i=0; i < ${#array[@]}; i++));
		do
			echo "$(($i + 1)),  ${array[$i]}"
    	done
		echo "*#*#*#*#*#**#*#**#*#**#**#**#*#**#"
	fi
}

