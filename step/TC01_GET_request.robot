*** Settings ***
Library     RequestsLibrary


*** Variables ***
${base_url}     http://reqres.in/api/
${user_id}      2


*** Test Cases ***
GET_Single_User
    Create Session    mySession    ${base_url}
    GET User

    Status Should Be    200


*** Keywords ***
Get User
    GET On Session    mySession    /user/${user_id}
