# FF2B - Base de Données

Ce dépôt contient la modélisation, le schéma physique SQL et la documentation technique de la base de données relationnelle centrale de la **Fédération Française de Badnieshton (FF2B)**.

Cette infrastructure constitue le socle unique d'information pour l'ensemble des services numériques de la fédération (gestion des personnes, licences, compétitions, cotisations, commissions).

---

## Choix Technologiques & Architecture - **SGBD**

- **PostgreSQL (v17+)**
- **Sqitch**

---

## Guide de Déploiement & Initialisation Rapide

### Prérequis

- Une instance **PostgreSQL** installée localement ou sur un serveur (ex: Docker, Supabase, Neon ou VPS OVH).
- Sqitch installé sur le système (Linux recommandé ou voir [ici](https://sqitch.org/download/) )

### 1. Cloner le dépôt

```
git clone https://github.com/FF2B-Badnieshton/ff2b-database.git
cd ff2b-database
```

### 2. Créer la base de données

### 3. Initialiser la Base de données avec Sqitch

Pour versionner la base de données, effectuer les migrations et faire des tests, on utilise **Sqitch.**

Pour plus d'informations sur **Sqitch**, allez voir le fichier *How to use squitch.md* ou directement la [documentation officiel](https://sqitch.org/docs/)

### 4. Exécuter le script d'injection des données de référence (`seed.sql`)

Ce script injecte la commune pilote Deshaies, les rôles administratifs, les types de documents et les statuts par défaut :

```
psql -U postgres -d ff2b_db -f sql/seed.sql
```

**Auteur / Lead Architecte BDD :** Alexandre

**Organisme :** Fédération Française de Badnieshton (FF2B)
