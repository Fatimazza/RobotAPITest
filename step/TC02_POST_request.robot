*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary


*** Variables ***
${base_url}     https://reqres.in/api
${user_mail}    eve.holt@reqres.in
${user_pass}    123456


*** Test Cases ***
TC 03: Register a User (POST) - Success
    Create Session    mySession    ${base_url}    verify=true
    ${body}=    Create Dictionary    email=${user_mail}    password=${user_pass}
    ${header}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=    POST On Session    mySession    /register    data=${body}
    ${json_object}=    To Json    ${response.content}
    # Using POST On Session with Header Return 400, Header only can be use in POST Request (deprecated)

    # Logs
    Log all responses(${response})

    # Validation
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    token
    ${token}=    Get Value From Json    ${json_object}    token
    Should Not Be Empty    ${token}

TC 04: Create a User (POST)
    Create Session    mySession    ${base_url}
    ${body}=    Create Dictionary    name=Izza    job=Lead QA Automation
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    mySession    /users    data=${body}
    # Using POST On Session with Header Return 400, Header only can be use in POST Request (deprecated)

    # Logs
    Log all responses(${response})

    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    Izza
    Should Contain    ${res_body}    Lead QA Automation


*** Keywords ***
Log all responses(${response})
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n
