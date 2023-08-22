*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Resource        ../resources/resources.robot
Variables       ../resources/data.py


*** Test Cases ***
TC 06: Delete a User (DELETE)
    Creating the session
    ${response}=    Deleting an user

    # Logs
    Log all responses(${response})

    # Validations
    Status code should be 204 No Content (${response})


*** Keywords ***
Deleting an user
    ${response}=    DELETE On Session    session    /users/${user_id}
    RETURN    ${response}
