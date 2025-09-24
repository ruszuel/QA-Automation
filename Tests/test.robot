*** Settings ***

Library    SeleniumLibrary
Library    ../CustomLibrary.py
Resource    ../Resources/App.resource
Resource    ../Resources/CustomerPage.resource

*** Variables ***
${URL}    https://marmelab.com/react-admin-demo
${USERNAME}    demo
${PASSWORD}    demo

*** Test Cases ***
TEST-000001
    [Documentation]    This is a sample test case.
    Launch Browser    ${URL}    ${login_txt_username}
    Login User    ${USERNAME}   ${PASSWORD}
    Sleep    10s
    
TEST-000002
    ${users}    Get Random Users 
    FOR    ${user}    IN    @{users}[:5]
        Go To Customers Page
        Create User    ${user}
        Verify Customer Data    ${user}
        # CLick Element    ${nav_btn_customer}
        Verify User Is Added    ${user}
    END


*** Keywords ***
Launch Browser
    [Arguments]    ${url}    ${element_to_wait}
    Open Browser    ${url}    chrome    options=add_argument("--start-maximized")
    Wait Until Keyword Succeeds    5x    .5s    Wait Until Element is Visible    ${element_to_wait}

Login User
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Input Text    ${login_txt_username}    ${username}
    Input Text    ${login_txt_password}    ${password}
    Click Button    ${login_btn_submit}

    ${status}    RUn Keyword And Return Status    Wait Until Element Is Visible    ${dashboard_hdr}

    IF    ${status}
        Log To Console    Login Successful
    ELSE 
        Log To Console Login Failed
    END
   
Verify User Is Added
    [Arguments]    ${user}
    Go To Customers Page
    Refresh Current Page
    ${fetched_name}    Get Text    ((${table})[1]//td)[2]
    IF    "\\n" in """${fetched_name}"""
        ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n","")[1:]
    END
    # Should Be Equal As Strings    ${user["name"].split(" ")[0]} ${user["name"].split(" ")[1]}    ${fetched_name}
    Should Contain     ${user["name"]}    ${fetched_name}
    