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
    Status Should Be    201
