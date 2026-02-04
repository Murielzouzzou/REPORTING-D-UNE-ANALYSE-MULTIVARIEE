# REPORTING-D-UNE-ANALYSE-MULTIVARIEE
Dans le cadre de la SAE 4.02 du BUT Science des Données, nous avons mené une étude  exploratoire autour de la thématique suivante : la typologie des communes françaises en  fonction des équipements disponibles. 
pratique du sport et aux soins médicaux associés. Plus précisément, notre analyse porte sur les 
communes françaises ayant entre 10 000 et 20 000 habitants. Cette taille intermédiaire permet 
de comparer des territoires ni trop petits pour manquer d’équipements, ni trop grands pour 
être statistiquement hors norme. Notre problématique est la suivante : 
Les communes françaises de taille moyenne présentent-elles des différences notables 
dans leur niveau d’équipement sportif et de présence de professionnels de santé 
spécialisés selon leur typologie (urbaine, rurale, périurbaine) ? 
Cette étude repose sur une base de données construite à partir de fichiers mis à disposition par 
l’INSEE, notamment les bases sur la population communale et les équipements publics. 
L’analyse est conduite à des fins d’aide à la décision territoriale, notamment pour éclairer les 
politiques publiques de répartition des ressources ou de développement des infrastructures.

# 🧭 Typologie des communes françaises — Analyse multivariée (ACP + Clustering)

## 🎯 Objectif du projet
Projet réalisé dans le cadre de la **SAE 4.02 – Analyse multivariée** du BUT Science des Données.  
L’objectif : **caractériser et classifier les communes françaises de 10 000 à 20 000 habitants selon leurs équipements sportifs et médicaux**, afin d’identifier des profils territoriaux utiles à l’aide à la décision publique.

---

## 🛠️ Compétences mobilisées
- **Data engineering** : nettoyage, jointures, harmonisation de données INSEE (population, équipements, typologie communale).
- **Analyse multivariée** :  
  - Analyse en Composantes Principales (ACP)  
  - Sélection de variables, standardisation, transformation log1p  
  - Interprétation des axes factoriels  
- **Machine learning non supervisé** : clustering sur espace factoriel (K-means).
- **Datavisualisation avancée** : screeplots, cercles des corrélations, projection des individus, visualisation des clusters.
- **Analyse territoriale** : typologie urbaine/rurale, lecture des disparités d’équipements.
- **Rédaction et communication** : rapport structuré, interprétation statistique, recommandations.

---

## 📂 Contenu du projet
- **Base de données consolidée** (~550 communes) :  
  population, typologie INSEE, équipements sportifs, professionnels de santé spécialisés.
- **ACP complète** :  
  - version brute  
  - version sans population totale  
  - version transformée log1p  
- **Interprétation des axes** :  
  - Axe 1 : niveau global d’équipement sportif  
  - Axe 2 : présence de professionnels de santé spécialisés  
  - Axe 3 : équipements plus rares ou spécifiques
- **Clustering** : 3 profils de communes identifiés.
- **Visualisations** : screeplots, cercles de corrélations, cartes factorielle, clusters.

---

## 📊 Résultats clés
- Les communes se structurent selon **deux dimensions majeures** :  
  1) densité d’équipements sportifs  
  2) offre médicale spécialisée  
- Trois profils émergent :  
  - **Communes bien dotées** (urbaines/périurbaines)  
  - **Communes spécialisées médicalement**  
  - **Communes peu équipées** (rurales)  
- L’exclusion de la population totale a permis de révéler des structures plus fines.  
- L’analyse fournit une **lecture opérationnelle** pour les politiques d’aménagement.

---

## 🧠 Ce que ce projet démontre
- Capacité à **construire une base de données complexe** à partir de sources officielles.  
- Maîtrise des **méthodes multivariées** et de leur interprétation.  
- Compétence en **clustering** et segmentation territoriale.  
- Rigueur dans la **validation méthodologique** (tests de plusieurs ACP, transformations).  
- Aptitude à **communiquer des résultats statistiques** de manière claire et exploitable.

---

## 📁 Organisation du dépôt
```
📦 SAE-Analyse-Multivariee
 ┣ 📄 README.md
 ┣ 📊 data/
 ┃   ┗ base_communes_INSEE.csv
 ┣ 📈 visualisations/
 ┃   ┗ *.png
 ┗ 📘 rapport/
     ┗ Reporting_ACP_Clustering.pdf
```
