*** Settings ***
Library     RequestsLibrary


*** Variables ***
${base_url}     http://reqres.in/api


*** Test Cases ***
CREATE_A_User
    Create Session    mySession    ${base_url}
    ${postBody}=    Create Dictionary    name=Izza    job=leadQA
    ${postHeader}=    Create Dictionary    Content-Type=application/json
    POST On Session    mySession    /user    data=${postBody}    headers=${postHeader}
    Status Should Be    200
