*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Resource        ../Resources/resources.robot
Variables       ../Resources/data.py


*** Test Cases ***
TC 03: Register a User (POST) - Success
    [Tags]    smoke

    # Request
    Creating the session
    ${response}=    Registering an user
    # Using POST On Session with Header Return 400, Header only can be use in POST Request (deprecated)

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})
    Response Header should contain application/json (${response})
    Response Body should contain non-empty token (${response})

TC 04: Create a User (POST)
    [Tags]    smoke

    # Request
    Creating the session
    ${response}=    Creating an user
    # Using POST On Session with Header Return 400, Header only can be use in POST Request (deprecated)

    # Logs
    Log all responses(${response})

    # Validations
    Status code should be 201 Created (${response})
    Response Header should contain application/json (${response})
    Response Body should contain name and job (${response})


*** Keywords ***
Registering an user
    ${header}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${body}=    Create Dictionary    email=${user_new_mail}    password=${user_password}
    ${response}=    POST On Session    session    /register    data=${body}
    RETURN    ${response}

Creating an user
    ${body}=    Create Dictionary    name=${user_name}    job=${user_job}
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    session    /users    data=${body}
    RETURN    ${response}

Response Body should contain non-empty token (${response})
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    token
    ${token}=    Get Value From Json    ${response.json()}    token
    Should Not Be Empty    ${token}

Response Body should contain name and job (${response})
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    ${user_name}
    Should Contain    ${response_body}    ${user_job}
