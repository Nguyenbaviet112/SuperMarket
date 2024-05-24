*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         String
Library         ../../Libraries/keyboard.py
Library         OperatingSystem
Library         ../../Libraries/keyboard.py
Resource        ../Keywords/Common.robot

*** Keywords ***

Begin Web Test
    [Arguments]  ${sheet_name}  ${tcs_name}  ${expect_value}
    ${browser} =  get return data from excel file  ${sheet_name}  ${tcs_name}  ${expect_value}
    register keyword to run on failure  capture page screenshot
    set selenium speed  0.1
    run keyword if  '${browser}'=='Chrome'  open browser  about:blank  ${browser}  options=add_argument("--ignore-certificate-errors"); add_experimental_option("excludeSwitches", ["enable-logging"])
    ...  ELSE IF  '${browser}'=='Edge'  open browser  about:blank  ${browser}  options=add_argument("--ignore-certificate-errors"); add_experimental_option("excludeSwitches", ["enable-logging"])
    ...  ELSE  open browser  about:blank  ${browser}  options=add_argument("--ignore-certificate-errors")
    maximize browser window
    ${dowload_path} =  get environment variable  USERPROFILE
    set global variable  ${PATH}   ${dowload_path}/Downloads

End Web Test
    close all browsers

Open SuperMarket Webpage
    [Arguments]  ${sheet_name}  ${tcs_name}  ${expect_value}
    ${application_URL} =  get return data from excel file  ${sheet_name}  ${tcs_name}  ${expect_value}
    go to  ${application_URL}
    ${byPassPopup} =  run keyword and return status  handle alert

Click GUI Element
    [Arguments]  ${locator}  ${timeout}=10s
    Verify WebPage Contains "Element"  ${locator}  ${timeout}
    ${status} =  run keyword and return status  click element  ${locator}

Input Text To TextBox
    [Arguments]  ${textbox_locator}   ${text}
    Scroll webpage to element      ${textbox_locator}
    Clear "Text" on TextBox  ${textbox_locator}
    input text   ${textbox_locator}   ${text}

Verify WebPage Contains "Element"
    [Arguments]  ${locator}  ${timeout}=5
    run keyword and continue on failure  wait until page contains element  ${locator}  ${timeout}

Verify WebPage "Does NOT Contain" "Element"
    [Arguments]  ${locator}  ${timeout}=5
    wait until page does not contain element  ${locator}  ${timeout}

Verify WebPage Contains "Text"
    [Arguments]  ${text}  ${timeout}=5
    run keyword and continue on failure  wait until page contains   ${text}  ${timeout}

Create Chrome Webdriver to disable safebrowsing
    ${CHROME_OPTIONS}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${PREFS}    Create Dictionary        safebrowsing.enabled=false
    Call Method    ${CHROME_OPTIONS}    add_argument    --start-maximized
    Call Method    ${CHROME_OPTIONS}    add_experimental_option    prefs    ${PREFS}
    Create Webdriver    Chrome    chrome_options=${CHROME_OPTIONS}

Wait until response from webpage
    [Arguments]  ${timeout}=5
    sleep  ${timeout}

Replace text in path
    [Arguments]  ${old_path}  ${string_to_replace}  ${input_string}
    ${String} =  Replace String   ${old_path}  ${string_to_replace}  ${input_string}
    [Return]  ${String}

Get text on location
    [Arguments]  ${locator}
    Verify WebPage Contains "Element"  ${locator}
    ${text} =  get text  ${locator}
    [Return]  ${text}

Clear "Text" on TextBox
    [Arguments]  ${textbox_locator}
    Verify WebPage Contains "Element"  ${textbox_locator}
    clear element text  ${textbox_locator}

Press key on locator
    [Arguments]  ${locator}  ${key}
    press keys  ${locator}  ${key}

Scroll webpage to element
    [Documentation]   
    [Arguments]  ${locator}
    Verify WebPage Contains "Element"  ${locator}
    ${old_locator} =  set variable  0
    ${new_locator} =  set variable  200
    FOR  ${count}  IN RANGE  0  12
    ${status} =  run keyword and return status  click element  ${locator}
    run keyword if  '${status}'!='True'
    ...  run keywords
    ...  Execute JavaScript  window.scrollTo(${old_locator},${new_locator});
    ...  AND  wait until response from webpage  1s
    exit for loop if  '${status}' == 'True'
    ${old_locator} =  run keyword if  '${status}' != 'True'  Plus two numbers    ${old_locator}    ${new_locator}
    ${new_locator} =  run keyword if  '${status}' != 'True'  Plus two numbers    ${new_locator}    200
    END





