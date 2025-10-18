#!/bin/bash

# Checking of error messages. If we expect an invokation to fail, I think we need need only to verify the exit status, not the output, since I do not think error messages, that is, the text, should be part of the API.

# TODO Automatic test case generation reading

script_path='./transpile.sh'
debugging_enabled="$1"
if [[ -z "$debugging_enabled" ]]
then
    echo >&2 "Error, no argument for the 'debugging enabled' parameter provided, exiting."
    exit 1
fi

t () {
    input="$1"
    expected_status="$2"
    expected_result="$3"

    actual_status=0
    actual_result=''

    echo -e "\nTesting '${input}'..."

    if [[ "$debugging_enabled" -eq 0 ]]
    then
        actual_result="$(
            printf "$input" \
                | "$script_path" \
                    2>/dev/null
        )"
        actual_status="$?"
    else
        actual_result="$(
            printf "$input" \
                | {
                    set -x
                    export SHELLOPTS
                    export PS4='+ (${LINENO}) '

                    "$script_path"
                }
        )"
        actual_status="$?"
    fi

    if [[ "$#" -eq 2 ]]
    then
        [[ "$actual_status" -eq "$expected_status" ]]
    else
        [[ "$actual_status" -eq "$expected_status" ]] \
            && [[ "$actual_result" == "$expected_result" ]]
    fi
}

{
    t \
        '' \
        1 \
        && t \
            '  ' \
            1 \
        && t \
            $'\t' \
            1 \
        && t \
            $'\t  ' \
            1 \
        && t \
            $'\n  ' \
            1 \
        && t \
            $'\n\t  ' \
            1 \
        && t \
            ' get' \
            1 \
        && t \
            'get' \
            1 \
        && t \
            'get ' \
            1 \
        && t \
            'get relations' \
            1 \
        && t \
            'get relations ' \
            1 \
        && t \
            'get relations abc' \
            1 \
        && t \
            'get relations "abc' \
            1 \
        && t \
            'get relations "abc"' \
            0 \
            'select * from abc;' \
        && t \
            ' get relations abc' \
            1 \
        && t \
            'get relations abc ' \
            1 \
        && t \
            'get relations abc ,' \
            1 \
        && t \
            'get relations abc,' \
            1 \
        && t \
            'get relations "abc, def"' \
            1 \
        && t \
            'get relations "  abc  ","  def  "' \
            1 \
        && t \
            'get relations "abc","def"' \
            0 \
            'select * from abc, def;' \
        && t \
            'get relations abc,def then' \
            1 \
        && t \
            'get relations "employees", "emails" then restrict tuples to "id" in "employees" equal "employee_id" in "emails" then restrict attributes to "name" in "employees", "email" in "emails"' \
            0 \
            'select employees.name, emails.email from employees, emails where (employees.id = emails.employee_id);'
} \
    && echo -e "\nAll tests succeeded." \
    || echo -e "\nA test failed."
