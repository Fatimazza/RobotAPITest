*** Settings ***
Library         RequestsLibrary
Variables       ./data.py


*** Keywords ***
Creating the session
    Create session    session    ${base_url}    verify=true

Getting user by ID
    ${response}=    GET On Session    session    /users/${user_id}
    RETURN    ${response}
