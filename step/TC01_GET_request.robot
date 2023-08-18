*** Settings ***
Library     RequestsLibrary


*** Variables ***
${base_url}     http://reqres.in/api/
${user_id}      2


*** Keywords ***
Get User
    GET On Session    mySession    /user/${user_id}
