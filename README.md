# TaxIonomie

Ce programme aide à définir et gérer une taxonomie, nomenclature ou hiérarchie à n niveaux.

Le nombre de niveaux n'est pas limité par la conception mais peut l'être par la performance.

Une taxionomie est un ensemble de taxions reliés entre eux par leurs TID.

## Taxion

Un taxion à un unique parent et peut avoir 0 à n enfants. 

Un taxion sans enfant est appelé feuille. Un taxion avec enfants est appelé noeud.

## TID

Un TID sert à identifier un taxion et à trouver ses ancètres. Et il peut identifier un objet quelconque.




## API
- Une taxionomie se construit avec TaxionomyEditor.

nota: seules les feuilles peuvent être renommées ou supprimées

- TaxionPicker permet de trouver un taxion dans la taxionomie
  
- TidPicker permet de trouver l'identifiant d'un taxion sans avoir à utiliser le taxion
  
- TaxionomyShow concrétise les taxions sous forme d'une liste


Nota 1 : data contient des exemples au format json.

Nota 2 : Dans une prochaine version, Nomenclature offrira des fonctions avancées pour transformer une taxionomie, telles que déplacer un sous-ensemble ou renommer un noeud.  

Nota 3 :
