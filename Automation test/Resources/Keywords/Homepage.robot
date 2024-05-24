*** Settings ***
Library     SeleniumLibrary
Resource    ../Common_resources/UI_Excel.robot
Resource    ../Data_xpath/Homepage.robot
Resource    ../Common_resources/Split_String.robot
Library     DateTime

*** Keywords ***
Verify SUPERMARKET title and contact exists on the page
    Verify WebPage Contains "Element"  ${Contact_home_page}   5s
    Wait until response from webpage  5s
    Verify WebPage Contains "Element"  ${SUPERMARKET_xpath}     5s 
    Wait until response from webpage  5s  

Search product on the page
    [Arguments]    ${sheet_name}    ${TC}     ${product_value}
    ${product_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${product_value}
    Scroll webpage to element   ${Search_input_xpath}
    Input Text To TextBox  ${Search_input_xpath}      ${product_excel}  
    Press key on locator  ${Search_input_xpath}   ENTER
    Wait until response from webpage  5s  

Verify result after searching 
    [Arguments]    ${sheet_name}    ${TC}     ${sp}
    ${product_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${sp}
    ${product_search_xpath}=   Replace text in path     ${product_item_xpath}      INPUT_NAME      ${product_excel}
    Verify WebPage Contains "Element"  ${product_search_xpath}

Clicking on Add To Cart button 
    Scroll webpage to element  ${Add_To_Cart_button_xpath}  
    Wait until response from webpage  4s

Click to cart icon
    Scroll webpage to element  ${Cart_xpath}   
    Wait until response from webpage  4s

Verify the product has been added in the cart    
    [Arguments]    ${sheet_name}    ${TC}     ${sp}
    ${product_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${sp}
    ${product_cart_xpath}=   Replace text in path     ${product_on_cart_xpath}      INPUT_NAME      ${product_excel}
    Verify WebPage Contains "Element"  ${product_cart_xpath}  5s

verify total number of products in cart page and total value on cart icon
    ${product_total}=   get text on location    ${total_product_on_cart_page} 
    ${total_value_on_cart_icon}=   get text on location     ${total_product_on_cart_icon}
    Compare two string  ${product_total}   ${total_value_on_cart_icon}

Clicking remove icon on Cart page 
    [Arguments]    ${sheet_name}    ${TC}     ${sp}
    ${product_excel}=   Get return data from Excel file      ${sheet_name}    ${TC}     ${sp}
    ${product_cart_xpath}=   Replace text in path     ${product_remove_icon_cart_page}      INPUT_NAME      ${product_excel}
    Scroll webpage to element      ${product_cart_xpath}  
    Wait until response from webpage  4s