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
CT-04 Création d'un compte utilisateur depuis le mode DEV de l'application Open Food Facts
    ${Bouton_Communauté} =    Set Variable    accessibility_id=Communauté
    Click Element    ${Bouton_Communauté}
    ${Créer_un_compte} =    Set Variable    accessibility_id=Créer un compte
    Click Element    ${Créer_un_compte}

    Wait Until Page Contains Element    ${Champ_Nom}    10s
    Click Element    ${Champ_Nom}
    ${Champ_Nom} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(0)
    Input Text    ${Champ_Nom}    BOUB
    ${Champ-Email} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${Champ-Email}
    Input Text    ${Champ-Email}    bouba-lourson@yahoo.fr
    ${Nom_Utilisateur} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(2)
    Click Element    ${Nom_Utilisateur}
    Input Text    ${Nom_Utilisateur}    ourson
    ${Mot_de_Passe} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(3)
    Click Element    ${Mot_de_Passe}
    Input Text    ${Mot_de_Passe}    Petitourson!
    ${Confirmation_MDP} =    Set Variable    android=new UiSelector().className("android.widget.EditText").instance(4)
    Click Element    ${Confirmation_MDP}
    Input Text    ${Confirmation_MDP}    Petitourson!
    ${Conditions_Utilisations} =    Set Variable
    ...    accessibility_id=conditions d'utilisation et de contribution d'Open Food Facts
    Click Element    ${Conditions_Utilisations}
    ${Producteur_Alimentaire} =    Set Variable    accessibility_id=Je suis un producteur alimentaire
    Click Element    ${Producteur_Alimentaire}
    ${Séléction_Champ_Producteur} =    Set Variable
    ...    android=new UiSelector().className("android.widget.EditText").instance(5)
    Click Element    ${Séléction_Champ_Producteur}
    Input Text    ${Séléction_Champ_Producteur}    Les Gateaux de Bouba
    ${Newsletter} =    Set Variable
    ...    accessibility_id=Je souhaite m'inscrire à la newsletter Open Food Facts (Vous pouvez vous désinscrire à tout moment)
    Click Element    ${Newsletter}
    ${Bouton_Inscription} =    Set Variable    accessibility_id=S'inscrire
    Click Element    ${Bouton_Inscription}

# Message qui apparaît dans une pop-up "Toutes nos félicitations ! Votre compte vient d’être créé. Présence d'un bouton OK".


*** Keywords ***
Open My Application
    Open Application    ${APPIUM_SERVER}    &{CAPS}
