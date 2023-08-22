*** Settings ***
Library         RequestsLibrary
Variables       ./data.py


*** Keywords ***
Creating the session
    Create session    session    ${base_url}    verify=true

Log all responses(${response})
    Log To Console    Response Status: ${response.status_code} \n
    Log To Console    Response Body: ${response.content} \n
    Log To Console    Response Header: ${response.headers} \n
