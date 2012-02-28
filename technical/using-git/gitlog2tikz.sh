#!/bin/sh

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

echo '.. tikz::'
echo '    :libs: calc'
echo ''
echo '    [x=12pt, y=12pt, every node/.style={inner sep=0.4ex}, very thick]'
echo ''

MAX_SUBJECT_LEN=50

# Extract the log and parse the entries
x=0; y=0; commits=(); lanes=(); virtual_commits=();
git log -n 30 --topo-order --reverse --format=format:C:%h%nP:%p%nS:%s%nEOR%n | while IFD= read -r line; do
    case "${line}" in
        'C:'*)
            commit="${line#C:}"
            ;;
        'P:'*)
            parents=(${line#P:})
            ;;
        'S:'*)
            subject="${line#S:}"
            ;;
        'EOR')
            # Add this commit to the list of commits we've processed
            commits=("${commits[@]}" "${commit}")

            # Create virtual parents if necessary
            for parent in ${parents[@]}; do
                if ! in_array "${parent}" "${commits[@]}"; then
                    if ! in_array "${parent}" "${virtual_commits[@]}"; then
                        # Add a virtual parent commit off the end of the diagram and in a new lane
                        virtual_commits=("${virtual_commits[@]}" "${parent}")
                        echo "    \\coordinate (${parent}virtual) at (-${#lanes[@]}, -1.5);"
                        lanes=("${lanes[@]}" "${parent}")
                        echo "    \\path let \p1 = (${parent}virtual) in coordinate (${parent}) at (\x1, ${y}-1.3);"
                        echo "    \\draw (${parent}virtual) -- (${parent});"
                    fi
                fi
            done

            # Follow the first parent
            first_parent="${parents[0]}"

            # Is there a lane for this parent?
            if in_array "${first_parent}" "${lanes[@]}"; then
                # Draw the commit node itself aligned to first parent
                echo "    \\path let \p1 = (${first_parent}) in (\x1, ${y}) node[draw,circle] (${commit}) {};"

                # Replace the parent in the lane
                lanes=(${lanes[@]/${first_parent}/${commit}})
            else
                # Create a new lane for this commit
                echo "    \\node[draw,circle] (${commit}) at (-${#lanes[@]}, ${y}) {};"
                lanes=("${lanes[@]}" "${commit}")
            fi

            if (( ${#subject} > ${MAX_SUBJECT_LEN} )); then
                subject="${subject:0:$((${MAX_SUBJECT_LEN}-3))}..."
            fi

            echo "    \\node[anchor=mid west] (${commit}-label) at (${x} + 1, ${y}) {\footnotesize\verb^${commit}: ${subject}^};"
            echo "    \\draw[color=black!25!white] (${commit}) -- (${commit}-label);"

            # Connect parents
            for parent in ${parents[@]}; do
                if in_array "${parent}" "${virtual_commits[@]}"; then
                    # Calculate relative offset from parent to commit
                    echo "    \\path (\$(${commit})-(${parent})\$); \\pgfgetlastxy{\deltax}{\deltay}"
                    echo "    \\pgfmathsetmacro{\absdeltax}{abs(\deltax)}"
                    echo "    \\draw (${parent}) -- ++(\deltax, \absdeltax pt) -- (${commit});"
                else
                    echo "    \\draw (${parent}) -- (${commit});"
                fi
            done

            y=$((${y}+1))
            ;;
        '')
            # skip blank lines
            ;;
        *)
            echo "unexpected output from git log: ${line}" >&2
    esac
done

