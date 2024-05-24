*** Settings ***
Library     SeleniumLibrary
Library     ../../Libraries/keyboard.py
Library     ExcelLibrary
Library     String
Library     DateTime
Resource    ../Common_resources/UI_Excel.robot

*** Keywords ***

Compare two string
    [Arguments]  ${expected}  ${actual}  ${case}=False
    run keyword and continue on failure  should be equal as strings  ${expected}  ${actual}  ignore_case=${case}

Open excel doc by sheet name
    [Arguments]  ${sheet_name}
    ${Excel_file_path} =  normalize path  D:/2022-2023/KCPM/DoAn/Excel/Data_file_excel.xlsx
    open excel document  ${Excel_file_path}  ${sheet_name}

Close excel docs
    close all excel documents

Get return data from Excel file
    [Arguments]  ${sheet_name}  ${tcs_name}  ${expect_value}
    FOR  ${row}  IN RANGE  2   1000
    ${data_return} =  read excel cell  ${row}  1  ${sheet_name}
    exit for loop if  '${data_return}'=='${tcs_name}'
    END
    FOR  ${column}  IN RANGE  2  1000
    ${data_return} =  read excel cell  1  ${column}  ${sheet_name}
    exit for loop if  '${data_return}'=='${expect_value}'
    END
    ${value_return} =  read excel cell  ${row}  ${column}  ${sheet_name}
    [Return]   ${value_return}

Verify broken image on webpage
    ${img_list} =  Get webelements by locator    //img
    ${err_list} =  verify_image_on_website    ${img_list}  src  ${staging_number}
    # log to console  ${err_list}[0]
    ${status} =  run keyword and return status  should be empty  ${err_list}[0]
    run keyword if  '${status}' != 'True'  run keyword
    ...  run keyword and continue on failure  fail  There are ${err_list}[1] broken images on page with several url: ${err_list}[0]