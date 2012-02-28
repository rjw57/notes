#!/bin/bash

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

echo '\begin{scope}[x=1em, y=1em, every node/.style={inner sep=0.4ex}, very thick]'

MAX_SUBJECT_LEN=50

# Extract the log and parse the entries
x=0; y=0; commits=(); lanes=(); connections=();
while read line; do
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
            # Trim the subject line
            if (( ${#subject} > ${MAX_SUBJECT_LEN} )); then
                subject="${subject:0:$((${MAX_SUBJECT_LEN}-3))}..."
            fi

            # Is this the first commit we're recording?
            if (( ${#lanes} == 0 )); then
                lanes=(${commit})
            fi

            x=0
            for lane_entry in ${lanes[@]}; do
                if [ "${lane_entry}" == "${commit}" ]; then
                    # Draw the commit node itself aligned to first parent
                    echo "\\path (-${x}, ${y}) node[draw,circle] (${commit}) {};"
                    echo "\\node[anchor=mid west] (${commit}-label) at (1, ${y})"
                    echo "{\footnotesize\verb^${commit}: ${subject}^};"
                    echo "\\draw[color=black!25!white] (${commit}) -- (${commit}-label);"

                    # Add this commit to the list of commits we've processed
                    commits=("${commits[@]}" "${commit}")
                fi
                x=$((${x} + 1))
            done

            if (( ${#parents[@]} > 0 )); then
                if in_array "${parents[0]}" "${lanes[@]}"; then
                    lanes=(${lanes[@]/${commit}/blank})
                else
                    lanes=(${lanes[@]/${commit}/${parents[0]}})
                fi
                connections=("${connections[@]}" "${commit}:${parents[0]}")
            fi

            echo "% pre: ${lanes[@]}"
            for parent in ${parents[@]:1}; do
                # Allocate the remaining parents' lanes
                if ! in_array "${parent}" "${lanes[@]}"; then
                    if in_array "blank" "${lanes[@]}"; then
                        new_lanes=()
                        for lane_elem in ${lanes[@]}; do
                            if [ "${lane_elem}" == "blank" ]; then
                                if ! in_array "${parent}" "${new_lanes[@]}"; then
                                    new_lanes=("${new_lanes[@]}" "${parent}")
                                else
                                    new_lanes=("${new_lanes[@]}" "${lane_elem}")
                                fi
                            else
                                new_lanes=("${new_lanes[@]}" "${lane_elem}")
                            fi
                        done
                        lanes=(${new_lanes[@]})
                    else
                        lanes=("${lanes[@]}" "${parent}")
                    fi
                fi

                # Record this connection
                connections=("${connections[@]}" "${commit}:${parent}")
            done
            echo "% post: ${lanes[@]}"

            y=$((${y}-1))
            ;;
        '')
            # skip blank lines
            ;;
        *)
            echo "unexpected output from git log: ${line}" >&2
    esac
done < <( git log $@ --topo-order --format=format:C:%h%nP:%p%nS:%s%nEOR%n )

# Create 'virtual' parent nodes for remaining lanes
x=0;
for parent in ${lanes[@]}; do
    if [ "${parent}" != "blank" ]; then
        echo "\\coordinate (${parent}) at (-${x}, ${y});"
    fi
    x=$((${x}+1))
done

for connection in ${connections[@]}; do
    commit=${connection%%:*}
    parent=${connection##*:}
    echo "\\path (\$(${parent})-(${commit})\$); \\pgfgetlastxy{\\deltax}{\\deltay}"
    echo "\\pgfmathsetmacro{\\absdeltax}{abs(\\deltax)}"
    echo "\\pgfmathsetmacro{\\slopey}{(abs(\\deltay) > abs(\\deltax)) && (\\absdeltax > 0)}"
    echo "\\pgfmathapproxequalto{\\slopey}{1}"
    echo "\\ifpgfmathcomparison"
    echo "\\draw[looseness=0.2,out=-90,in=90] (${commit}) to ++(\\deltax, -\\absdeltax pt) -- (${parent});"
    echo "\\else"
    echo "\\draw[looseness=0.4,out=-90,in=90] (${commit}) to (${parent});"
    echo "\\fi"
done

echo '\end{scope}'
