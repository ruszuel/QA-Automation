*** Settings ***

Library    SeleniumLibrary
Variables    ../Variables/customerpage.py
Variables    ../Variables/variables.py
Library    ../Library/CustomLibrary.py

*** Variables ***


*** Keywords ***

Log Users Data
    ${row_count}    Get Element Count    ${table}
    FOR    ${row}    IN RANGE    1    ${row_count + 1}
        ${fetched_name}    Get Text    ((${table})[${row}]//td)[2]
        IF    "\\n" in """${fetched_name}"""
            ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n","")[1:]
        END
        ${last_seen}    Get Text    ((${table})[${row}]//td)[3]
        ${orders}    Get Text    ((${table})[${row}]//td)[4]
        ${total_spent}    Get Text    ((${table})[${row}]//td)[5]
        ${latest_purchase}    Get Text    ((${table})[${row}]//td)[6]
        ${news}    Get Element Attribute    ((${table})[${row}]//td)[7]//*[name()='svg']    aria-label
        ${segments}    Get Text    ((${table})[${row}]//td)[8]
        ${formatted_segments}    Evaluate    """${segments}""".strip().replace("\\n", ", ") if """${segments}""".strip() else "N/A"

        Log To Console    \n====== User ${row} ======
        Log To Console    Name: ${fetched_name}
        Log To Console    Last seen: ${last_seen}
        Log To Console    Orders: ${orders}
        Log To Console    Total Spent: ${total_spent}
        Log To Console    Latest Purchase: ${latest_purchase}
        Log To Console    Newsletter: ${news}
        Log To Console    Segments: ${formatted_segments}
    END