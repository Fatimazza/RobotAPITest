*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Resource        ../resources/resources.robot
Variables       ../resources/data.py


*** Test Cases ***
TC 05: Register a User (PUT)
    [Tags]    smoke

    # Request
    Creating the session
    ${response}=    Updating user job

    # Logs
    Log all responses(${response})

    # Validations
    Status code should be 200 Success (${response})
    Response Body should contain date and new job (${response})


*** Keywords ***
Updating user job
    ${body}=    Create Dictionary    job=${user_new_job}
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=    PUT On Session    session    /users/${user_id}    data=${body}
    RETURN    ${response}

Response Body should contain date and new job (${response})
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    date
    ${job}=    Get Value From Json    ${response.json()}    job
    Should Contain    ${job}    ${user_new_job}
