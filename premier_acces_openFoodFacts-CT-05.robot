*** Settings ***
Library     AppiumLibrary
# Test Teardown    Close Application
Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood

Resource    ./Variables/variables-globales.robot

*** Variables ***
${NEXT}     accessibility_id=Next
${AUTHORISE}    accessibility_id=Authorize
${PERMISSION_CONTROLLER}         id=com.android.permissioncontroller:id/permission_allow_foreground_only_button

${SUIVANT}      accessibility_id=Suivant


*** Test Cases ***
Login
    # précondition: la localisation est en English(United States) dans les paramètres système de l'émulateur

    # Premier accès à l'application OpenFoodFacts
    Launch App

    VAR    ${el1} =    accessibility_id=Continue
    Wait Until Element Is Visible    ${el1}    timeout=5s
    Click Element    ${el1}

    Click Element    xpath=//*[contains(@content-desc, "United States")]

    VAR    ${el3} =    class=android.widget.EditText
    Click Element    ${el3}
    Input Text    ${el3}    france

    VAR    ${el4} =    accessibility_id=OpenFoodFactsCountry.FRANCE
    Wait Until Element Is Visible    ${el4}    timeout=5s
    Click Element    ${el4}

    Repeat Keyword    4 times    Clic Next

    Wait Until Element Is Visible    ${AUTHORISE}    timeout=5s
    Click Element    ${AUTHORISE}

    Wait Until Element Is Visible    ${PERMISSION_CONTROLLER}    timeout=5s
    Click Element    ${PERMISSION_CONTROLLER}

    Sleep     10s

Accès à la page d'accueil en français
    # précondition: la localisation est en Français dans les paramètres système de l'émulateur

    # Premier accès à l'application OpenFoodFacts
    Launch App

    VAR    ${el1} =    accessibility_id=Continuer
    Wait Until Element Is Visible    ${el1}    timeout=10s
    Click Element    ${el1}

    Repeat Keyword    4 times    Clic Suivant

    VAR     ${el9} =        accessibility_id=Autoriser
    Wait Until Element Is Visible    ${el9}    timeout=10s
    Click Element    ${el9}

    Wait Until Element Is Visible    ${PERMISSION_CONTROLLER}    timeout=5s
    Click Element    ${PERMISSION_CONTROLLER}

    Sleep    10s


*** Keywords ***
Launch App
    Open Application
    ...    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:noReset=${NO_RESET}

Clic Next
    Wait Until Element Is Visible    ${NEXT}    timeout=10s
    Click Element    ${NEXT}

Clic Suivant
    Wait Until Element Is Visible    ${SUIVANT}    timeout=10s
    Click Element    ${SUIVANT}
