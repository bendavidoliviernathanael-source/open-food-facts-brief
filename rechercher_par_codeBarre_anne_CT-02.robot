*** Settings ***
Library             AppiumLibrary
Resource    ./Variables/variables-globales.robot

Test Teardown       Close Application
# Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood

*** Variables ***
${CODE_BARRE}       3250391781966
${DESIGNATION_PRODUIT}      accessibility_id=Moutarde de dijon bio
${CHERCHER_PRODUIT}     accessibility_id=Chercher un produit


*** Test Cases ***
Recherche d'un produit par son code barre
    Launch App

    # page de recherche

    Wait Until Element Is Visible    ${CHERCHER_PRODUIT}    timeout=5s
    Click Element    ${CHERCHER_PRODUIT}

    Sleep     5s
    VAR    ${el12}    class=android.widget.EditText
    Wait Until Element Is Visible    ${el12}    timeout=5s
    Click Element    ${el12}

    Input Text    ${el12}    ${CODE_BARRE}

    VAR    ${el13}    accessibility_id=Rechercher
    Click Element    ${el13}

    Expect Element    ${DESIGNATION_PRODUIT}    visible

    Sleep    5s


*** Keywords ***
Launch App
    Open Application
    ...    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:noReset=true
