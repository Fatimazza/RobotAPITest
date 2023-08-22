*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary
Resource        ../Resources/resources.robot
Variables       ../Resources/data.py


*** Variables ***
${base_url}     https://reqres.in/api
${user_id}      2


*** Test Cases ***
TC 01: Get single User (GET)
    Create Session    mySession    ${base_url}
    ${response}=    Get User

    # Logs
    Log all responses(${response})

    # Validation
    Status Should Be    200
    ${responseStatus}=    Convert To String    ${response.status_code}
    Should Be Equal    200    ${responseStatus}

    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    Weaver

    ${responseHeadersContentType}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${responseHeadersContentType}    application/json

TC 02: Get single User with POM (GET)
    Creating the session
    ${response}=    Getting user by ID
    ${json_object}=    to json    ${response.content}

    # Logs
    Log all responses(${response})

    # Validation
    ${responseStatus}=    Convert To String    ${response.status_code}
    Should Be Equal    200    ${responseStatus}
    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    ${user_id}
    Should Contain    ${responseBody}    ${user_default_mail}
    ${responseHeadersContentType}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${responseHeadersContentType}    application/json

    # Validation Alternative
    ${email}=    Get Value From Json    ${json_object}    data.email
    Should Be Equal    ${email[0]}    ${user_default_mail}
    ${last_name}=    Get Value From Json    ${json_object}    data.last_name
    Should Be equal    ${last_name[0]}    Weaver


*** Keywords ***
Get User
    # This is only used in TC01 - TC 01
    ${myResponse}=    GET On Session    mySession    /users/${user_id}
    RETURN    ${myResponse}

Log all responses(${response})
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n
