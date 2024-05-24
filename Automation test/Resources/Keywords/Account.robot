*** Settings ***
Library     SeleniumLibrary
Resource    ../Common_resources/UI_Excel.robot
Resource    ../Data_xpath/Homepage.robot
Resource    ../Data_xpath/Account.robot
Resource    ../Common_resources/Split_String.robot
Library     DateTime

*** Keywords ***
Clicking on Create Account button 
    Scroll webpage to element  ${Create_Account_button_xpath} 
    Wait until response from webpage  5s

Clicking on Log in button 
    Scroll webpage to element  ${Login_button_xpath}
    Wait until response from webpage  5s

Input User Name/Password on Login page 
    [Arguments]     ${sheet_name}    ${TC}     ${value_input}       
    ${value_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${value_input}
    ${data}=   Split string by value expect   ${value_excel}  ;
    Scroll webpage to element  ${User_name_login_input_xpath} 
    Input Text To TextBox       ${User_name_login_input_xpath}       ${data}[0]  
    Wait until response from webpage  3s
    Scroll webpage to element  ${Password_input_xpath}   
    Input Text To TextBox      ${Password_input_xpath}       ${data}[1]  

Login User 
    Scroll webpage to element    ${Log_in_xpath} 
    Wait until response from webpage  10s

Verify User after logined succesfully  
    [Arguments]     ${sheet_name}    ${TC}     ${value_input}       
    ${value_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${value_input}
    ${data}=   Split string by value expect   ${value_excel}  ;
    ${User_xpath}=   Replace text in path     ${Account_xpath}     INPUT_NAME     ${data}[0]
    Verify WebPage Contains "Element"  ${User_xpath}   
    Wait until response from webpage  4s
    Verify WebPage "Does NOT Contain" "Element"  ${Create_Account_button_xpath}    5s

Clicking on Logout button 
    [Arguments]     ${sheet_name}    ${TC}     ${value_input}       
    ${value_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${value_input}
    ${data}=   Split string by value expect   ${value_excel}  ;
    ${User_xpath}=   Replace text in path     ${Account_xpath}     INPUT_NAME     ${data}[0]
    Scroll webpage to element   ${User_xpath}
    Verify WebPage Contains "Element"  ${User_xpath}   
    Wait until response from webpage  4s
    Verify WebPage Contains "Element"  ${Log_out_button_xpath}    5s    
    Scroll webpage to element  ${Log_out_button_xpath}
    Wait until response from webpage  4s
    Verify WebPage Contains "Element"  ${Create_Account_button_xpath}    5s
    Verify WebPage Contains "Element"  ${Login_button_xpath}     5s 

Verify error message after logined 
    [Arguments]     ${sheet_name}    ${TC}     ${error_message}       
    ${error_message_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${error_message}
    Verify WebPage Contains "Text"  ${error_message_excel}   5s

Clicking on Home button 
    Scroll webpage to element  ${Home_button_xpath}

Verify Top selling offers exists on page 
    Verify WebPage Contains "Element"    ${Top_selling_offers_title_xpath}

Clicking on Register Here button 
    Scroll webpage to element   ${Register_Here_button_xpath}    
    verify WebPage Contains "Element"  ${Register_Here_title_xpath} 
    Wait until response from webpage  5s
