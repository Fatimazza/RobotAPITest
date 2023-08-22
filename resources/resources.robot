*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       ./data.py


*** Keywords ***
Creating the session
    Create session    session    ${base_url}    verify=true

Log all responses(${response})
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n

Status code should be 200 Success (${response})
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    200    ${status_code}

Status code should be 201 Created (${response})
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201

Response Header should contain application/json (${response})
    ${response_header}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${response_header}    application/json
