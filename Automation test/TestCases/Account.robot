
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
[TCS01]-Log in but enter the wrong password
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Clicking on Log in button 
    Input User Name/Password on Login page   Account   TC01    User-Password
    Login User 
    Verify error message after logined    Account   TC01   Error message
    Tear down for testcase

[TCS02]- Login but enter wrong User name
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Clicking on Log in button 
    Input User Name/Password on Login page   Account   TC02    User-Password
    Login User 
    Verify error message after logined    Account   TC02   Error message
    Clicking on Log in button 
    Tear down for testcase
   

[TCS03]- User login but click Home button/Register Here button 
    [Setup]  Set up for testcase
    Homepage.Verify SUPERMARKET title and contact exists on the page
    Clicking on Log in button 
    Input User Name/Password on Login page   Account   TC02    User-Password
    Clicking on Home button 
    Verify Top selling offers exists on page 
    Clicking on Log in button 
    Input User Name/Password on Login page   Account   TC02    User-Password
    Clicking on Register Here button 
    Tear down for testcase
    