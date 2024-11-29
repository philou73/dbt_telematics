# 📊 Développement de pipelines ETL sur des données télématiques

## 📝 Description
Un projet dbt conçu pour transformer des données brutes en un entrepôt de données prêt à l'analyse. Ce projet facilite :
- La modélisation des données.
- La documentation automatisée.
- Les tests de qualité des données.

---

## 🚀 Fonctionnalités
- **Modèles clairs et réutilisables** : Transformation des données avec des modèles staging, intermédiaires et mart.
- **Documentation** : Génération automatique pour chaque modèle.
- **Qualité des données** : Tests intégrés pour valider les résultats.

---

## 📦 Structure du Projet
Voici la structure générale du projet dbt :

```plaintext
dbt_telematics/
│
├── models/
│   ├── staging/        # Modèles de préparation (ex. stg_telematics.sql)
│   ├── intermediate/   # Modèles intermédiaires (ex. int_measures_in_periods.sql)
│   ├── mart/           # Modèles finaux pour l'analyse (ex. fact_rapid_turns.sql)
│
├── macros/             # Macros réutilisables pour dbt
├── tests/              # Tests personnalisés
├── data/               # Données statiques ou exemples
├── snapshots/          # Snapshots de données
└── README.md           # Documentation du projet