*** Settings ***
Library             AppiumLibrary
Resource    keywords_communs_Olivier-Nathanaël.robot

Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood

*** Test Cases ***
Consulter une fiche produit test 1
      Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)

Consulter une fiche produit test 2
    Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit


*** Keywords ***
Faire une configuration initiale
    Appuyer sur un bouton visible    accessibility_id=Continuer
    Appuyer sur un bouton visible    accessibility_id=Suivant
    Appuyer sur un bouton visible    accessibility_id=Suivant
    Appuyer sur un bouton visible    accessibility_id=Suivant
    Appuyer sur un bouton visible    accessibility_id=Suivant
    Appuyer sur un bouton visible    accessibility_id=Plus tard

Chercher un produit
    [Arguments]    ${nom du produit}
    Appuyer sur un bouton visible    accessibility_id=Chercher un produit
    Saisir un texte dans une zone de saisie visible    ${nom du produit}    class=android.widget.EditText
    Appuyer sur un bouton visible    accessibility_id=Rechercher

Vérifier des propriétés d'une fiche d'un produit
    # la page contient le texte Goût Original
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    xpath=//android.view.View[@content-desc="Goût Original"]
    ...    20s
    Vérifier que l'écran contient un texte    Goût Original

    # la page contient un onglet santé
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Santé\nOnglet 1 sur 6"]
    ...    10s
    Vérifier que l'écran contient un texte    Santé

    # la page contient une rubrique nutrition (qui contient l'information nutriscore)
    # Vérifier que un élément a un texte    //android.view.View[@content-desc="Nutrition"]    Nutrition
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Nutrition"]
    ...    10s
    Vérifier que l'écran contient un texte    Nutrition
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.widget.Button[@content-desc="Nutri-Score E"]
    ...    10s
    Vérifier que l'écran contient un texte    Nutri-Score E

    # la page contient une rubrique Ingrédients (qui contient l'information quantité d'ingrédients)
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Ingrédients"]
    ...    10s
    Vérifier que l'écran contient un texte    Ingrédients
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.widget.Button[@content-desc="9 ingrédients"]
    ...    10s
    Vérifier que l'écran contient un texte    9 ingrédients

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)
    Démarrer openfoodfacts   ${False}
    Faire une configuration initiale
    Chercher un produit    coca cola
    Appuyer sur un bouton visible    android=new UiSelector().description("Photo du produit (recto)").instance(0)
    Vérifier des propriétés d'une fiche d'un produit
    Démarrer une attente pendant une durée  2s

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit
    Démarrer openfoodfacts    ${True}
    Chercher un produit    coca cola
    Appuyer sur un bouton visible    android=new UiSelector().description("Photo du produit (recto)").instance(0)
    Vérifier des propriétés d'une fiche d'un produit
    Démarrer une attente pendant une durée  2s
