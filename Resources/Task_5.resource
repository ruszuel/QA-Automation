*** Settings ***

Library    SeleniumLibrary
Variables    ../Variables/customerpage.py
Variables    ../Variables/variables.py
Library    ../Library/CustomLibrary.py
Resource    ./CustomerPage.resource

*** Keywords ***
Analyze Users Spending
    Go To Customers Page
    ${total}    Set Variable    0

    ${row_count}    Get Element Count    ${table}
    FOR    ${row}    IN RANGE    1    ${row_count + 1}
        ${fetched_name}    Get Text    ((${table})[${row}]//td)[2]
        IF    "\\n" in """${fetched_name}"""
            ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n","")[1:]
        END
        ${total_spent}    Get Text    ((${table})[${row}]//td)[5]
        ${amount}    Parse Currency    ${total_spent}
        IF    ${amount} > 0
            Log To Console    \n${fetched_name}: ${total_spent}
            ${total}    Evaluate    ${total} + ${amount}
        END
    END
    
    ${result}    Evaluate    float(${total}) > 3500
    Should Be True    ${result}     msg=Expected ${total} to be greater than 3500
    
    Log To Console    =============================
    Log To Console    Total User Spending: ${total}
    Log To Console    =============================

