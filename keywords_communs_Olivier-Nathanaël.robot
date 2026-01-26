*** Settings ***
Library     AppiumLibrary


*** Keywords ***
# Opérations sur le téléphone
Démarrer openfoodfacts
    [Arguments]    ${booléen noReset}
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    appium:automationName=UIAutomator2
    ...    appium:appPackage=openfoodfacts.github.scrachx.openfood
    ...    appium:noReset=${booléen noReset}

Démarrer une attente pendant une durée
    [Arguments]    ${durée}
    Sleep    ${durée}

# Vérifications

Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    [Arguments]    ${identifiant de l'élément}    ${durée}
    Wait Until Element Is Visible    ${identifiant de l'élément}    timeout=${durée}

Vérifier que l'écran contient un élément
    [Arguments]    ${identifiant de l'élément}
    Page Should Contain Element    ${identifiant de l'élément}

Vérifier que l'écran contient un texte
    [Arguments]    ${texte}
    Page Should Contain Text    ${texte}

Vérifier que l'écran ne contient pas un texte
    [Arguments]    ${texte}
    Page Should Not Contain Text    ${texte}

Vérifier que un élément est égal à un autre élément
    [Arguments]    ${identifiant de l'élément 1}    ${identifiant de l'élément 2}
    Should Be Equal    ${identifiant de l'élément 1}    ${identifiant de l'élément 2}

Vérifier que un élément a un texte
    [Arguments]    ${identifiant de l'élément}    ${texte}
    Element Text Should Be    ${identifiant de l'élément}    ${texte}

# Obtention d'éléments

Obtenir la valeur d'un attribut d'un élément
    [Arguments]    ${identifiant de l'attribut}    ${identifiant de l'élément}
    ${elt} =    Get Element Attribute    ${identifiant de l'élément}    ${identifiant de l'attribut}
    RETURN    ${elt}

# Interactions avec le téléphone

Appuyer sur un bouton visible
    [Arguments]    ${identifiant du bouton}
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale  ${identifiant du bouton}    120s
    Click Element    ${identifiant du bouton}

Saisir un texte dans une zone de saisie visible
    [Arguments]    ${texte}    ${identifiant de la zone de saisie}
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    ${identifiant de la zone de saisie}
    ...    10s
    Input Text    ${identifiant de la zone de saisie}    ${texte}
