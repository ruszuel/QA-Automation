*** Settings ***

Library    SeleniumLibrary
Variables    ../customerpage.py
Library    ../CustomLibrary.py

*** Keywords ***

Go To Customers Page
    CLick Element    ${nav_btn_customer}
    Wait Until Element Is Visible    //table//tbody//tr    timeout=10s

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
    Capture Page Screenshot

Verify Customer Data
    [Arguments]    ${user}
    ${first_name}    Get Element Attribute    ${customer_txt_fname}    value
    ${last_name}    Get Element Attribute    ${customer_txt_lname}    value
    ${customer_email}    Get Element Attribute    ${customer_txt_email}    value
    ${customer_birthday}    Get Element Attribute    ${customer_txt_birthday}    value
    ${formatted_date}    Format Date    ${user["birthday"]}
    # IF    ('${user["name"].split(" ")[0]}' == '${first_name}') and ('${user["name"].split(" ")[1]}' == '${last_name}')
    #     Log To Console    firstname and lastname are equal 
    # END
    Should Be Equal As Strings    '${formatted_date}'    '${customer_birthday}'
    CLick Element    ${nav_btn_customer}