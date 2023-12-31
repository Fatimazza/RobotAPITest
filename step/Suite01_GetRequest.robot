*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Resource        ../resources/resources.robot
Variables       ../resources/data.py


*** Test Cases ***
TC 01: Get a User (GET)
    [Documentation]    This test case verifies that the response code of the GET Request should be 200.
    ...    The response body contains the 'user id' key with value as '2', the valid 'email',
    ...    and the valid 'last name'.
    [Tags]    smoke

    # Request
    Creating the session
    ${response}=    Getting user by ID

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})
    Response Header should contain application/json (${response})
    Response Body should contain user id and email (${response})
    Response Body should contain last name (${response})
    # Validation Alternative
    Response Body should contain default email (${response})
    Response Body should contain default last name (${response})

TC 02: Get list of Users (GET)
    [Tags]    smoke

    # Request
    Creating the session
    ${response}=    Getting list of users by page

    # Logs
    Log all responses(${response})

    # Validation
    Status code should be 200 Success (${response})
    Response Header should contain application/json (${response})
    Response Body should contain correct page (${response})
    Response Body should contain correct length of email (${response})
    Response Body should contain list of users (${response})


*** Keywords ***
Getting user by ID
    ${response}=    GET On Session    session    /users/${user_id}
    RETURN    ${response}

Getting list of users by page
    ${response}=    GET On Session    session    /users?page\=${page_id}
    RETURN    ${response}

Response Body should contain user id and email (${response})
    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    ${user_id}
    Should Contain    ${responseBody}    ${user_default_mail}

Response Body should contain last name (${response})
    ${responseBody}=    Convert To String    ${response.content}
    Should Contain    ${responseBody}    Weaver

Response Body should contain default email (${response})
    ${email}=    Get Value From Json    ${response.json()}    data.email
    Should Be Equal    ${email[0]}    ${user_default_mail}

Response Body should contain default last name (${response})
    ${last_name}=    Get Value From Json    ${response.json()}    data.last_name
    Should Be equal    ${last_name[0]}    Weaver

Response Body should contain correct page (${response})
    ${response_page}=    Get Value From Json    ${response.json()}    page
    ${page}=    Convert To Integer    ${page_id}
    Should Be equal    ${response_page[0]}    ${page}

Response Body should contain correct length of email (${response})
    ${response_emails}=    Get Value From Json    ${response.json()}    $..email
    ${email_count}=    Get Length    ${response_emails}
    Should Be Equal    ${user_list_length}    ${email_count}

Response Body should contain list of users (${response})
    ${response_first_names}=    Get Value From Json    ${response.json()}    $..first_name
    # alternative - 1
    Should Contain Any    ${response_first_names}    Michael    Lindsay    Tobias    Byron    George    Rachel
    # alternative - 2
    Lists Should Be Equal    ${response_first_names}    ${user_list}
    # alternative - 3
    FOR    ${first_names}    IN    @{response_first_names}
        Log To Console    ${first_names} \n
        List Should Contain Value    ${user_list}    ${first_names}
    END
