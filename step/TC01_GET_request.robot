*** Settings ***
Library         RequestsLibrary
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
    Response Header should contain application/json (${response})
    Response Body should contain last name (${response})

TC 02: Get single User with POM (GET)
    Creating the session
    ${response}=    Getting user by ID

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})
    Response Header should contain application/json (${response})
    Response Body should contain user id and email (${response})

    # Validation Alternative
    Response Body should contain default email (${response})
    Response Body should contain default last name (${response})


*** Keywords ***
Getting user by ID
    ${response}=    GET On Session    session    /users/${user_id}
    RETURN    ${response}

Response Body should contain last name (${response})
    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    Weaver

Response Body should contain user id and email (${response})
    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    ${user_id}
    Should Contain    ${responseBody}    ${user_default_mail}

Response Body should contain default email (${response})
    ${email}=    Get Value From Json    ${response.json()}    data.email
    Should Be Equal    ${email[0]}    ${user_default_mail}

Response Body should contain default last name (${response})
    ${last_name}=    Get Value From Json    ${response.json()}    data.last_name
    Should Be equal    ${last_name[0]}    Weaver
