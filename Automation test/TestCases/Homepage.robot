
*** Settings ***
Documentation       Checking keywords
Library             SeleniumLibrary
Resource            ../Resources/Common_resources/UI_Excel.robot
Resource            ../Resources/Data_xpath/Homepage.robot
Resource            ../Resources/Keywords/Homepage.robot
Resource            ../Resources/Keywords/Account.robot
Library             Collections
Library             String

Suite Setup  Open excel doc by sheet name  webpage
Suite Teardown  Close excel docs

*** Keywords ***


Set up for testcase
    Begin Web Test  webpage  page  Browser
    UI_Excel.Open SuperMarket Webpage  webpage  page  URL

Tear down for testcase
    End Web Test

*** Test Cases ***
[TCS01]-Searching for products and Add product to cart but not logged in
    [Documentation]   Go to Supermarket page 
    ...               Verify SUPERMARKET title and contact exists on the page
    ...               Search product
    ...               Verify product after searching
    ...               Add to cart 
    ...               Verify product after adding
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Homepage.Search product on the page      Products   TC01        Product
    Homepage.Verify result after searching     Products   TC01        Product
    Homepage.Clicking on Add To Cart button 
    Homepage.Click to cart icon
    Homepage.Verify the product has been added in the cart    Products   TC01        Product
    Homepage.verify total number of products in cart page and total value on cart icon
    Tear down for testcase
    
[TCS02]-Searching for products after logged in  
    [Documentation]   Go to Supermarket page 
    ...               Verify SUPERMARKET title and contact exists on the page
    ...               Log in User
    ...               Search product
    ...               Verify product after searching
    ...               Log out 
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Clicking on Log in button 
    Input User Name/Password on Login page   Products   TC02    User-Password
    Login User 
    Verify User after logined succesfully     Products   TC02    User-Password
    Homepage.Search product on the page      Products   TC02        Product
    Homepage.Verify result after searching     Products   TC02        Product
    Clicking on Add To Cart button 
    Click to cart icon
    Verify the product has been added in the cart    Products   TC02        Product
    verify total number of products in cart page and total value on cart icon
    Clicking on Logout button      Products   TC02    User-Password
    Tear down for testcase
    

[TCS03]-Remove products from cart
    [Documentation]   Go to Supermarket page 
    ...               Verify SUPERMARKET title and contact exists on the page
    ...               Log in User
    ...               Search product
    ...               Add product
    ...               Remove products from cart
    ...               Verify result after removing
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Clicking on Log in button 
    Input User Name/Password on Login page   Products   TC03    User-Password
    Login User 
    Verify User after logined succesfully     Products   TC03    User-Password
    Homepage.Search product on the page      Products   TC03        Product
    Homepage.Verify result after searching     Products   TC03        Product
    Clicking on Add To Cart button 
    Click to cart icon
    Verify the product has been added in the cart    Products   TC03        Product
    verify total number of products in cart page and total value on cart icon
    Clicking remove icon on Cart page      Products   TC03        Product
    press_ENTER
    Wait until response from webpage  10s
    Tear down for testcase
        

    
