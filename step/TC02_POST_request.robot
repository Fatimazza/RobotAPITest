*** Settings ***
Library     RequestsLibrary


*** Variables ***
${base_url}     https://reqres.in/api


*** Test Cases ***
TC 04: Create a User (POST)
    Create Session    mySession    ${base_url}
    ${body}=    Create Dictionary    name=Izza    job=Lead QA Automation
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    mySession    /users    data=${body}
    # Using POST On Session with Header Return 400, Header only can be use in POST Request (deprecated)

    # Logs
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n

    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${res_body}=    Convert To String    ${response.content}
    Should Contain    ${res_body}    Izza
    Should Contain    ${res_body}    Lead QA Automation
