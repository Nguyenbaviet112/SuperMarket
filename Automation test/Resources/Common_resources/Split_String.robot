
*** Settings ***
Library         OperatingSystem
Library         String
Library         ../../Libraries/keyboard.py
Library         SeleniumLibrary
Library         OperatingSystem
Library         ../../Libraries/keyboard.py


*** Variables ***


*** Keywords ***
Check String Contains SubString
    [Arguments]  ${string}  ${sub_string}
    LOG  Check whether "${string}" contains "${sub_string}"
    ${contains}=  Evaluate   "${sub_string}" in """${string}"""
    [Return]   ${contains}

Split input string to characters
    [Arguments]  ${string}
    ${characters} =  split string to characters  ${string}
    [Return]  ${characters}

Split return text to lines
    [Arguments]  ${index}
    ${text} =  split to lines  ${index}
    [Return]  ${text}

Remove string by value expect
    [Arguments]  ${string}  ${value}
    ${text} =  remove string  ${string}  ${value}
    [Return]  ${text}

Split string by value expect
    [Arguments]  ${string}  ${value}=${None}
    ${text} =  split string  ${string}  ${value}
    [Return]  ${text}


