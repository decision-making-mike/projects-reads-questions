#!/bin/bash

# This is a transpiler from my DQL to SQL's DQL.

# "string" restoring. In case a function updates "string", if the function fails, we need to be sure that "string" is the same as if the function was not executed.

# TODO Fine-grained error messages. They should be generated earliest that we can provide meaningful information about the cause of the error to the user.

parse_query_clause () {
    parse_relation_clause \
        && sql_from_clause="from $current_sql_from_clause_list" \
        && {
            local tmp="$string"

            {
                parse_whitespace_list \
                    && parse_tuple_restriction_clause
            } \
                && {
                    sql_where_clause=" where $current_sql_where_clause_list"
                    tmp="$string"
                } \
                || string="$tmp"

            {
                parse_whitespace_list \
                    && parse_attribute_restriction_clause
            } \
                && sql_select_clause="select $current_sql_select_clause_list" \
                || {
                    if [[ -z "$string" ]]
                    then sql_select_clause='select *'
                    else string="$tmp"
                    fi
                }

            true
        } \
        && [[ -z "$string" ]]
}

parse_relation_clause () {
    local tmp="$string"

    {
        parse_literal 'get' \
            && parse_whitespace_list \
            && parse_literal 'relations' \
            && parse_whitespace_list \
            && parse_relation_names_list
    } \
        || {
            string="$tmp"
            false
        }
}

parse_literal () {
    expected="$1"

    if grep >/dev/null "^$expected" <( printf "$string" )
    then string="$( sed "s/^$expected//" <( printf "$string" ) )"
    else false
    fi
}

parse_whitespace_list () {
    if grep >/dev/null '^[ \t]' <( printf "$string" )
    then string="$( sed 's/^[ \t]*//' <( printf "$string" ) )"
    else false
    fi
}

parse_relation_names_list () {
    local current_sql_from_clause_list_tmp="$current_sql_from_clause_list"
    current_sql_from_clause_list=''

    parse_relation_name \
        && current_sql_from_clause_list+="$current_sql_relation_name" \
        && {
            local failures_count=0
            local tmp

            while true
            do
                tmp="$string"
                current_sql_from_clause_list_tmp="$current_sql_from_clause_list"

                parse_whitespace_list

                parse_literal ',' \
                    && current_sql_from_clause_list+=', ' \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_whitespace_list

                parse_relation_name \
                    && current_sql_from_clause_list+="$current_sql_relation_name" \
                    || {
                        (( ++failures_count ))
                        current_sql_from_clause_list="$current_sql_from_clause_list_tmp"
                        break
                    }
            done

            if (( failures_count % 2 != 0 ))
            then string="$tmp"
            fi
        }
}

parse_relation_name () {
    local tmp="$string"
    local current_sql_relation_name_tmp="$current_sql_relation_name"

    {
        parse_literal '"' \
            && {
                pattern='^[a-z_]\+'

                if grep >/dev/null "$pattern" <( printf "$string" )
                then
                    current_sql_relation_name="$( grep --only-matching "$pattern" <( printf "$string" ) )"
                    string="$( sed "s/$pattern//" <( printf "$string" ) )"
                else false
                fi
            } \
            && parse_literal '"'
    } \
        || {
            string="$tmp"
            current_sql_relation_name="$current_sql_relation_name_tmp"
            false
        }
}

parse_tuple_restriction_clause () {
    local tmp="$string"

    {
        parse_literal 'then' \
            && parse_whitespace_list \
            && parse_literal 'restrict' \
            && parse_whitespace_list \
            && parse_literal 'tuples' \
            && parse_whitespace_list \
            && parse_literal 'to' \
            && parse_whitespace_list \
            && parse_conjunction_list
    } \
        && current_sql_where_clause_list="$current_sql_conjunction_list" \
        || {
            string="$tmp"
            false
        }
}

parse_conjunction_list () {
    local current_sql_conjunction_list_tmp="$current_sql_conjunction_list"
    current_sql_conjunction_list=''

    parse_disjunction_list \
        && current_sql_conjunction_list+="(${current_sql_disjunction_list})" \
        && {
            local failures_count=0
            local tmp=''

            while true
            do
                tmp="$string"
                current_sql_conjunction_list_tmp="$current_sql_conjunction_list"

                parse_whitespace_list \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_literal 'and' \
                    && current_sql_conjunction_list+=' and ' \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_whitespace_list \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_disjunction_list \
                    && current_sql_conjunction_list+="(${current_sql_disjunction_list})" \
                    || {
                        (( ++failures_count ))
                        current_sql_conjunction_list="$current_sql_conjunction_list_tmp"
                        break
                    }
            done

            if (( failures_count % 2 != 0 ))
            then string="$tmp"
            fi
        }
}

parse_disjunction_list () {
    local current_sql_disjunction_list_tmp="$current_sql_disjunction_list"
    current_sql_disjunction_list=''

    parse_negation_clause \
        && current_sql_disjunction_list+="$current_sql_negation" \
        && {
            local failures_count=0
            local tmp=''

            while true
            do
                tmp="$string"
                current_sql_disjunction_list_tmp+="$current_sql_disjunction_list" \

                parse_whitespace_list \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_literal 'or' \
                    && current_sql_disjunction_list+=' or ' \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_whitespace_list \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_negation_clause \
                    && current_sql_disjunction_list+="$current_sql_negation" \
                    || {
                        (( ++failures_count ))
                        current_sql_disjunction_list="$current_sql_disjunction_list_tmp"
                        break
                    }
            done

            if (( failures_count % 2 != 0 ))
            then string="$tmp"
            fi
        }
}

parse_negation_clause () {
    local current_sql_negation_tmp="$current_sql_negation"
    local tmp="$string"

    {
        parse_literal 'not' \
            && parse_whitespace_list
    } \
        && current_sql_negation+='not ' \
        || string="$tmp"

    parse_sql_condition \
        && current_sql_negation+="$current_sql_condition" \
        || current_sql_negation="$current_sql_negation_tmp"
}

parse_sql_condition () {
    local tmp="$string"
    local current_sql_condition_tmp="$current_sql_condition"
    current_sql_condition=''

    {
        {
            parse_qualified_attribute_name \
                && current_sql_condition+="$current_sql_qualified_attribute_name"
        } \
            && parse_whitespace_list \
            && {
                parse_literal 'equal' \
                    && current_sql_condition+=' = '
            } \
            && parse_whitespace_list \
            && {
                parse_qualified_attribute_name \
                    && current_sql_condition+="$current_sql_qualified_attribute_name"
            }
    } \
        || {
            string="$tmp"
            current_sql_condition="$current_sql_condition_tmp"
            false
        }
}

parse_qualified_attribute_name () {
    local tmp="$string"
    local current_sql_qualified_attribute_name_tmp="$current_sql_qualified_attribute_name"

    {
        parse_attribute_name \
            && parse_whitespace_list \
            && parse_literal 'in' \
            && parse_whitespace_list \
            && parse_relation_name
    } \
        && current_sql_qualified_attribute_name="${current_sql_relation_name}.${current_sql_attribute_name}" \
        || {
            string="$tmp"
            current_sql_qualified_attribute_name="$current_sql_qualified_attribute_name_tmp"
            false
        }
}

parse_attribute_name () {
    local tmp="$string"
    local current_sql_attribute_name_tmp="$current_sql_attribute_name"

    {
        parse_literal '"' \
            && {
                pattern='^[a-z_]\+'

                if grep >/dev/null "$pattern" <( printf "$string" )
                then
                    current_sql_attribute_name="$( grep --only-matching "$pattern" <( printf "$string" ) )"
                    string="$( sed "s/$pattern//" <( printf "$string" ) )"
                else false
                fi
            } \
            && parse_literal '"'
    } \
        || {
            string="$tmp"
            current_sql_attribute_name="$current_sql_attribute_name_tmp"
            false
        }
}

parse_attribute_restriction_clause () {
    local tmp="$string"

    {
        parse_literal 'then' \
            && parse_whitespace_list \
            && parse_literal 'restrict' \
            && parse_whitespace_list \
            && parse_literal 'attributes' \
            && parse_whitespace_list \
            && parse_literal 'to' \
            && parse_whitespace_list \
            && parse_qualified_attribute_names_list
    } \
        || {
            string="$tmp"
            false
        }
}

parse_qualified_attribute_names_list () {
    local current_sql_select_clause_list_tmp="$current_sql_select_clause_list"
    current_sql_select_clause_list=''

    parse_qualified_attribute_name \
        && current_sql_select_clause_list+="$current_sql_qualified_attribute_name" \
        && {
            local failures_count=0
            local tmp=''

            while true
            do
                tmp="$string"
                current_sql_select_clause_list_tmp="$current_sql_select_clause_list"

                parse_whitespace_list

                parse_literal ',' \
                    && current_sql_select_clause_list+=', ' \
                    || {
                        (( ++failures_count ))
                        break
                    }

                parse_whitespace_list

                parse_qualified_attribute_name \
                    && current_sql_select_clause_list+="$current_sql_qualified_attribute_name" \
                    || {
                        (( ++failures_count ))
                        current_sql_select_clause_list="$current_sql_select_clause_list_tmp"
                        break
                    }
            done

            if (( failures_count % 2 != 0 ))
            then string="$tmp"
            fi
        }
}

# We substitute newlines beforehand since various commands can just stop on them. If we did not do this here, we would need to handle newlines for every command separately. Thus we break the nice one-to-one correspondence between the "parse_whitespace_list" function and the EBNF, but we save overall code simplicity.
string="$(
    tr '\n' ' ' \
        | sed 's/^[ \t]*//' \
        | sed 's/[ \t]*$//'
)"
sql_select_clause=''
sql_from_clause=''
sql_where_clause=''
current_sql_relation_name=''
current_sql_from_clause_list=''
current_sql_select_clause_list=''
current_sql_qualified_attribute_name=''
current_sql_attribute_name=''
current_sql_where_clause_list=''
current_sql_conjunction_list=''
current_conjunction_clause=''
current_sql_condition=''

if parse_query_clause
then echo "${sql_select_clause} ${sql_from_clause}${sql_where_clause};"
else
    echo >&2 'Error, the input does not form a query, exiting.'
    false
fi
