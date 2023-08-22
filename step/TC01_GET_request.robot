*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary
Resource        ../resources/resources.robot
Variables       ../resources/data.py


*** Test Cases ***
TC 01: Get single User (GET)
    Creating the session
    ${response}=    Getting user by ID

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})

    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    Weaver

    ${responseHeadersContentType}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${responseHeadersContentType}    application/json

TC 02: Get single User with POM (GET)
    Creating the session
    ${response}=    Getting user by ID

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})

    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    ${user_id}
    Should Contain    ${responseBody}    ${user_default_mail}
    ${responseHeadersContentType}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${responseHeadersContentType}    application/json

    # Validation Alternative
    ${email}=    Get Value From Json    ${response.json()}    data.email
    Should Be Equal    ${email[0]}    ${user_default_mail}
    ${last_name}=    Get Value From Json    ${response.json()}    data.last_name
    Should Be equal    ${last_name[0]}    Weaver


*** Keywords ***
Getting user by ID
    ${response}=    GET On Session    session    /users/${user_id}
    RETURN    ${response}
