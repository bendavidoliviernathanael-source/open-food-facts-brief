*** Settings ***
Library             AppiumLibrary

Suite Setup         Open My Application
Suite Teardown      Close Application
Test Teardown       Terminate Application    openfoodfacts.github.scrachx.openfood


*** Variables ***
${APPIUM_SERVER}    http://127.0.0.1:4723

&{CAPS}
...                 platformName=Android
...                 automationName=UiAutomator2
...                 appPackage=openfoodfacts.github.scrachx.openfood
...                 noReset=${TRUE}
...                 fullReset=${FALSE}


*** Test Cases ***
CT-01 Vérifier que Rechercher un produit par son nom permet d'obtenir une liste de produits
    ${champ_recherche_accueil}=    Set Variable    accessibility_id=Chercher un produit
    Click Element    ${champ_recherche_accueil}

    ${champ_recherche}=    Set Variable    class =android.widget.EditText
    Click Element    ${champ_recherche}
    Input Text    ${champ_recherche}    COCA COLA PET 1.25L CT

    ${loupe}=    Set Variable    accessibility_id=Rechercher
    Click Element    ${loupe}

    # 1) Attendre que l'écran de résultats s'affiche (bandeau "X produits")
    Wait Until Page Contains Element    xpath=//android.view.View[contains(@content-desc,"produits")]    15s

    # 2) Vérifier qu'il y a au moins 1 item produit cliquable
    ${nb_items}=    Get Matching Xpath Count
    ...    xpath=//android.view.View[@clickable="true" and contains(@content-desc,"%")]
    Should Be True    ${nb_items} > 0    Aucun produit affiché (liste vide)


*** Keywords ***
Open My Application
    Open Application    ${APPIUM_SERVER}    &{CAPS}
