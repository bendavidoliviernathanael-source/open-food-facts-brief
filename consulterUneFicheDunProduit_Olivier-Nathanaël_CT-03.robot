*** Settings ***
Library             AppiumLibrary
Resource    keywords_communs_Olivier-Nathanaël.robot

Test Teardown    Terminate Application    openfoodfacts.github.scrachx.openfood

*** Test Cases ***
Consulter une fiche produit test 1
    Skip  Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)

Consulter une fiche produit test 2
    Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit


*** Keywords ***
Faire une configuration initiale
    ${elt1} =    Set Variable    accessibility_id=Continuer
    ${elt2} =    Set Variable    accessibility_id=Suivant
    ${elt3} =    Set Variable    accessibility_id=Plus tard
    Appuyer sur un bouton visible  ${elt1}
    Appuyer sur un bouton visible    ${elt2}
    Appuyer sur un bouton visible    ${elt2}
    Appuyer sur un bouton visible    ${elt2}
    Appuyer sur un bouton visible    ${elt2}
    Appuyer sur un bouton visible    ${elt3}

Chercher un produit
    [Arguments]    ${nom du produit}
    Appuyer sur un bouton visible    accessibility_id=Chercher un produit
    Saisir un texte dans une zone de saisie visible    ${nom du produit}    class=android.widget.EditText
    Appuyer sur un bouton visible    accessibility_id=Rechercher

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit (premier démarrage)
    Démarrer openfoodfacts (premier démarrage)
    Faire une configuration initiale
    Chercher un produit    coca cola
    Appuyer sur un bouton visible    android=new UiSelector().description("Photo du produit (recto)").instance(0)

    # assertion 2 : l'élément avec ce xpath a un attribut dont la valeur devrait être égale à Goût Original
    ${el5} =    Set Variable    xpath=//android.view.View[@content-desc="Goût Original"]
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale    ${el5}    10s
    ${desc} =    Get Element Attribute    ${el5}    content-desc
    Vérifier que un élément est égal à un autre élément    ${desc}    Goût Original
    Vérifier que l'écran contient un élément    accessibility_id=Goût Original
    Vérifier que l'écran contient un texte    Goût Original

Vérifier que consulter une fiche produit permet d'accéder à plusieurs informations concernant ce produit
    Démarrer openfoodfacts
    Chercher un produit    coca cola
    Appuyer sur un bouton visible    android=new UiSelector().description("Photo du produit (recto)").instance(0)

    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    xpath=//android.view.View[@content-desc="Goût Original"]
    ...    10s
    ${desc} =    Obtenir la valeur d'un attribut d'un élément
    ...    content-desc
    ...    xpath=//android.view.View[@content-desc="Goût Original"]
    Vérifier que un élément est égal à un autre élément    ${desc}    Goût Original
    Vérifier que l'écran contient un élément    accessibility_id=Goût Original
    Vérifier que l'écran contient un texte    Goût Original

    # la page contient un onglet santé
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Santé\nOnglet 1 sur 6"]
    ...    10s
    ${desc} =    Obtenir la valeur d'un attribut d'un élément
    ...    content-desc
    ...    //android.view.View[@content-desc="Santé\nOnglet 1 sur 6"]
    Vérifier que l'écran contient un texte    Santé
    Vérifier que un élément est égal à un autre élément    ${desc}    Santé\nOnglet 1 sur 6

    # la page contient une rubrique nutrition (qui contient l'information nutriscore)
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Nutrition"]
    ...    10s
    ${desc} =    Obtenir la valeur d'un attribut d'un élément
    ...    content-desc
    ...    //android.view.View[@content-desc="Nutrition"]
    Vérifier que l'écran contient un texte    Nutrition
    Vérifier que un élément est égal à un autre élément    ${desc}    Nutrition

    # la page contient une rubrique Ingrédients (qui contient l'information quantité d'ingrédients)
    Attendre jusqu'à ce que un élément soit visible pendant une durée maximale
    ...    //android.view.View[@content-desc="Ingrédients"]
    ...    10s
    ${desc} =    Obtenir la valeur d'un attribut d'un élément
    ...    content-desc
    ...    //android.view.View[@content-desc="Ingrédients"]
    Vérifier que l'écran contient un texte    Ingrédients
    Vérifier que un élément est égal à un autre élément    ${desc}    Ingrédients
