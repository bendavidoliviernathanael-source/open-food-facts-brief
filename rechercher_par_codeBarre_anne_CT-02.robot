*** Settings ***
Library             AppiumLibrary
Resource            ./Variables/variables-globales.robot

# Test Teardown    Close Application
Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Variables ***
# ${CODE_BARRE}    3250391781966
# ${DESIGNATION_PRODUIT}    accessibility_id=Moutarde de dijon bio
${CHERCHER_PRODUIT}     accessibility_id=Chercher un produit
${Rechercher}           class=android.widget.EditText

&{PRODUITS}
...                     3250391781966=Moutarde de dijon bio
...                     3057640257773=Eau Minérale Naturelle
...                     5449000214911=Coca-Cola


*** Test Cases ***
Recherche d'un produit par son code barre
    # on lance l'application et on arrive que la page d'accueil du site
    Launch App

    # page de recherche, cliquer sur la barre de recherche
    Wait Until Element Is Visible    ${CHERCHER_PRODUIT}    timeout=5s
    Click Element    ${CHERCHER_PRODUIT}

    Sleep    5s

    # changement d'écran
    # cliquer sur la barre de recherche en haut de la fenêtre
    Wait Until Element Is Visible    ${Rechercher}    timeout=5s
    Click Element    ${Rechercher}

    VAR    ${cpt}    =0
    FOR    ${code}    ${designation}    IN    &{PRODUITS}
        Rechercher un code barre    ${code}
        Sleep    5s
        Vérifier code barre = désignation    ${designation}
        VAR    ${cpt}    Evaluate    ${cpt} + 1
        Log To Console    ${cpt}
        Log To Console    ${designation}
    END


*** Keywords ***
Launch App
    Open Application
    ...    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:noReset=true

# faire la fonction qui prend en paramètre le produit
# le code barre est envoyé à la barre de recherche

Rechercher un code barre
    [Arguments]    ${CODE}
    Input Text    ${Rechercher}    ${CODE}
    # on clique sur la loupe pour lancer la recherche
    VAR    ${loupe}    accessibility_id=Rechercher
    Click Element    ${loupe}

Vérifier code barre = désignation
    [Arguments]    ${DESIGNATION}
    Sleep    5s
    Page Should Contain Text    ${DESIGNATION}
    # le test doit se terminer à l'état initial du test
    Press Keycode    4
    Wait Until Element Is Visible    ${Rechercher}    timeout=10s
    Clear Text    ${Rechercher}
