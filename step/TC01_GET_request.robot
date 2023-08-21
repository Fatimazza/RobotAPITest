*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${base_url}     http://reqres.in/api
${user_id}      2


*** Test Cases ***
TC 01: Get single User (GET)
    Create Session    mySession    ${base_url}
    ${response}=    Get User

    # Logs
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n

    # Validation
    Status Should Be    200
    ${responseStatus}=    Convert To String    ${response.status_code}
    Should Be Equal    200    ${responseStatus}

    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    Weaver

    ${responseHeadersContentType}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${responseHeadersContentType}    application/json


*** Keywords ***
Get User
    # This is only used in TC01 - TC 01
    ${myResponse}=    GET On Session    mySession    /users/${user_id}
    RETURN    ${myResponse}
