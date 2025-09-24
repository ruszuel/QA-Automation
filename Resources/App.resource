*** Settings ***
Library    SeleniumLibrary
Library    ../CustomLibrary.py
Variables    ../variables.py

*** Keywords ***

Refresh Current Page
    CLick Button   ${btn_refresh}
    Wait Until Element Is Visible    ${loading_icon}
    Wait Until Element Is Not Visible    ${loading_icon}