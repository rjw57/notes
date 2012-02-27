#!/bin/sh

# Arguments are: "y-coord" "[|\*]* <commit hash>"
function tikz_commit_node()
{
    # Do nothing with no arguments
    if [ "$#" == "0" ]; then
        return
    fi

    # Get the line
    _y=$1; _line=$2

    # Get node position string, '|' is a space, '*' is this node
    _cur_pos=0
    _x=-1
    while [[ "$_line" == [\|\*]\ * ]]; do
        case "$_line" in
            '* '*)
                _x=${_cur_pos}
                _line=${_line#\* }
                ;;

            '| '*)
                _line=${_line#\| }
                ;;

            *)
                echo "Unknown positioning character at head of line: $_line" >/dev/null
                return
        esac
        # Advance x-position
        _cur_pos=$(($_cur_pos + 1))
    done
    _graph_width=${_cur_pos}

    # Remaining line is commit hash
    _line_array=(${_line})

    # Get commit and parent hashes
    _commit=${_line_array[0]}

    # Write node
    echo "    \\node[draw, circle] at (-${_x}, ${_y}) (${_commit}) {};"
}

# Check if a value exists in an array
# @param $1 mixed  Needle  
# @param $2 array  Haystack
# @return  Success (0) if value exists, Failure (1) otherwise
# Usage: in_array "$needle" "${haystack[@]}"
# See: http://fvue.nl/wiki/Bash:_Check_if_array_element_exists
in_array() {
    local hay needle=$1
    shift
    for hay; do
        [[ $hay == $needle ]] && return 0
    done
    return 1
}

GIT_LOG_ARGS=$@
MAX_SUBJECT_LENGTH=62

# get git's output, skip lines without a '*' in them
git_log=`git log ${GIT_LOG_ARGS} --graph "--pretty=format:%h %p : %s" | grep '\*'`

echo '.. tikz::'
echo '    :libs: calc'
echo ''

# Output a set of nodes for the commit
_y=0
echo '    \begin{scope}[x=1.2em, y=1.2em, every node/.style={inner sep=0.4ex}]'
echo "${git_log}" | while read line; do
    tikz_commit_node "${_y}" "${line}"
    _y=$((${_y} - 1))
done

# Get a lit of commits in this log
_commits=(`echo "${git_log}" | sed -e 's/^[\|\* ]*//' | cut -f 1 -d ' '`)

# Output the paths connecting the nodes
_y=0
echo '    \begin{scope}[out=90,in=-90,thin]'
echo "${git_log}" | sed -e 's/^[\|\* ]*//' | while read line; do
    _line_array=(${line})

    _commit=${_line_array[0]}
    _line_array=(${_line_array[@]:1})

    _parents=()
    while [[ ${_line_array[0]} == [^:]* ]]; do
        _parents=("${_parents[@]}" ${_line_array[0]})
        _line_array=(${_line_array[@]:1})
    done

    _subject=${_line_array[@]:1}
    if (( ${#_subject} > ${MAX_SUBJECT_LENGTH}-3 )); then
        _subject="${_subject:0:${MAX_SUBJECT_LENGTH}-3}..."
    fi
    echo "    \\node[anchor=mid west] at (0.5, ${_y}) (${_commit}-label) {\small\texttt{${_commit}}: \verb|${_subject}|};"

    if in_array "${_commit}" "${_commits[@]}"; then

        for _parent in ${_parents[@]}; do
            if in_array ${_parent} "${_commits[@]}"; then
                # Calculate relative offset from parent to commit
                echo "    \\path (\$(${_commit})-(${_parent})\$); \\pgfgetlastxy{\deltax}{\deltay}"

                # Calculate a 'splay' angle to throw commit arrow out at depending on x-offset
                echo "    \\pgfmathsetmacro{\splayangle}{(\deltax<-1pt)?120:((\deltax>1pt)?60:90))}"

                # Choose whether to splay based on y-separation
                echo "    \\pgfmathsetmacro{\outangle}{(\deltay > 2em)?\splayangle:90}"
                echo "    \\draw[out=\outangle] let \p1 = (${_parent}), \p2 = (${_commit}) in"
                echo "    (${_parent}) to (\x2,\y1+0.8em+0.3*\deltay-0.3*1.2em) -- (${_commit});"
            else
                echo "    \\draw let \p1 = (${_commit}) in (${_commit}) -- (\x1, 0.5-${#_commits[@]});"
                echo "    \\draw[dotted] let \p1 = (${_commit}) in (\x1, 0.5-${#_commits[@]}) -- (\x1, -${#_commits[@]});"
            fi
        done
    fi

    _y=$((${_y} - 1))
done
echo '    \end{scope}'

echo '    \end{scope}'

