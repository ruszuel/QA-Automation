*** Settings ***

Library    SeleniumLibrary
Variables    ../Variables/customerpage.py
Variables    ../Variables/variables.py
Library    ../Library/CustomLibrary.py

*** Keywords ***

Go To Customers Page
    CLick Element    ${nav_btn_customer}
    Wait Until Element Is Visible    ${table}    

Create User
    [Arguments]    ${user}
    Click Element    ${customer_btn_create}  
    Wait Until Element Is Visible    ${customer_btn_save} 
    Input Text    ${customer_txt_fname}    ${user["name"].split(" ")[0]}   
    Input Text    ${customer_txt_lname}    ${user["name"].split(" ")[1]}  
    Input Text    ${customer_txt_email}    ${user["email"]}
    Input Text    ${customer_txt_birthday}    ${user["birthday"]}
    Input Text    ${customer_txt_address}    ${user["address"]["street"]} ${user["address"]["suite"]} 
    Input Text    ${customer_txt_city}    ${user["address"]["city"]}    
    Input Text    ${customer_txt_stateAbbr}   ${user["address"]["stateAbbr"]}
    Input Text    ${customer_txt_zipcode}    ${user["address"]["zipcode"]}
    Input Text    ${customer_txt_password}    ${user["password"]}
    Input Text    ${customer_txt_confirm_password}    ${user["password"]}
    Click Element    ${customer_btn_save}   

    Wait Until Page Contains    Customer created


Verify Customer Data
    [Arguments]    ${user}
    Wait Until Page Contains    History
    ${first_name}    Get Element Attribute    ${customer_txt_fname}    value
    ${last_name}    Get Element Attribute    ${customer_txt_lname}    value
    ${customer_email}    Get Element Attribute    ${customer_txt_email}    value
    ${birthday}    Get Element Attribute    ${customer_txt_birthday}    value
    ${customer_address}    Get Element Attribute    ${customer_txt_address}    value
    ${customer_city}    Get Element Attribute    ${customer_txt_city}    value
    ${customer_state}    Get Element Attribute    ${customer_txt_stateAbbr}    value
    ${customer_zipcode}    Get Element Attribute    ${customer_txt_zipcode}    value
    ${formatted_date}    Format Date    ${user["birthday"]}

    Should Be Equal As Strings    ${user["name"].split(" ")[0]}    ${first_name}
    Should Be Equal As Strings    ${user["name"].split(" ")[1]}    ${last_name}
    Should Be Equal As Strings    ${user["email"]}    ${customer_email}
    Should Be Equal As Strings    ${user["address"]["street"]} ${user["address"]["suite"]}    ${customer_address}
    Should Be Equal As Strings    ${user["address"]["city"]}    ${customer_city}
    Should Be Equal As Strings    ${user["address"]["stateAbbr"]}    ${customer_state}
    Should Be Equal As Strings    ${user["address"]["zipcode"]}    ${customer_zipcode}
    Should Be Equal As Strings    ${formatted_date}    ${birthday}
    Log To Console    Formatted Date: ${formatted_date} | Fetched Date: ${birthday}
    # CLick Element    ${nav_btn_customer}
Update Existing User    
    [Arguments]    ${customer}
    Wait Until Element Is Visible    xpath=//table//tbody//tr[${customer["id"]}]
    Click Element    xpath=//table//tbody//tr[${customer["id"]}]
    
    Wait Until Element Is Visible    ${customer_btn_save} 
    Press Keys     ${customer_txt_fname}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_fname}    ${customer["name"].split(" ")[0]}

    Press Keys     ${customer_txt_lname}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_lname}    ${customer["name"].split(" ")[1]}

    Press Keys     ${customer_txt_email}    CTRL+A     BACKSPACE  
    Input Text    ${customer_txt_email}    ${customer["email"]}

    Input Text    ${customer_txt_birthday}    ${customer["birthday"]}

    Press Keys     ${customer_txt_address}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_address}    ${customer["address"]["street"]} ${customer["address"]["suite"]} 

    Press Keys     ${customer_txt_city}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_city}    ${customer["address"]["city"]}   

    Press Keys     ${customer_txt_stateAbbr}    CTRL+A     BACKSPACE 
    Input Text    ${customer_txt_stateAbbr}   ${customer["address"]["stateAbbr"]}

    Press Keys     ${customer_txt_zipcode}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_zipcode}    ${customer["address"]["zipcode"]}

    Press Keys     ${customer_txt_password}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_password}    ${customer["password"]}
    Press Keys     ${customer_txt_confirm_password}    CTRL+A     BACKSPACE
    Input Text    ${customer_txt_confirm_password}    ${customer["password"]}
    Click Element    ${customer_btn_save}   