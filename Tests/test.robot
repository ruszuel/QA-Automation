*** Settings ***

Library    SeleniumLibrary
Library    ../Library/CustomLibrary.py
Resource    ../Resources/App.resource
Resource    ../Resources/CustomerPage.resource
Resource    ../Resources/Task_4.resource
Resource    ../Resources/Task_5.resource
Suite Setup    Login User    ${USERNAME}   ${PASSWORD}

*** Variables ***
${URL}    https://marmelab.com/react-admin-demo
${USERNAME}    demo
${PASSWORD}    demo

*** Test Cases ***
# TEST-000001
#     [Documentation]    This is a sample test case.
#     Launch Browser    ${URL}    ${login_txt_username}
#     Login User    ${USERNAME}   ${PASSWORD}
    
TEST-000001
    ${users}    Get Random Users 
    FOR    ${user}    IN    @{users}[:5]
        Go To Customers Page
        Create User    ${user}
        Verify Customer Data    ${user}
        Verify User Is Added    ${user}
    END

TEST_000002
    ${customers}    Get Random Users 
    FOR    ${customer}    IN    @{customers}[5:10]
        Go To Customers Page
        Update Existing User    ${customer}
        Sleep    3s
    END

TEST_000003
    Log Users Data

TEST_000004
    Analyze Users Spending
    
*** Keywords ***
Launch Browser
    [Arguments]    ${url}    ${element_to_wait}
    Open Browser    ${url}    chrome    options=add_argument("--start-maximized")
    Wait Until Keyword Succeeds    5x    .5s    Wait Until Element is Visible    ${element_to_wait}

Login User
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Launch Browser    ${URL}    ${login_txt_username}
    Input Text    ${login_txt_username}    ${username}
    Input Text    ${login_txt_password}    ${password}
    Click Button    ${login_btn_submit}

    ${status}    RUn Keyword And Return Status    Wait Until Element Is Visible    ${dashboard_hdr}

    IF    ${status}
        Log To Console    Login Successful
    ELSE 
        Log To Console     Login Failed
    END
   
Verify User Is Added
    [Arguments]    ${user}
    Go To Customers Page
    Refresh Current Page
    ${fetched_name}    Get Text    ((${table})[1]//td)[2]
    IF    "\\n" in """${fetched_name}"""
        ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n","")[1:]
    END
    Should Be Equal As Strings      '${user["name"]}'    '${fetched_name}'
    