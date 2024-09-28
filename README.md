### Objectifs

- **Optimiser le temps de développement** : Investir dans des solutions permettant de réduire les coûts à long terme.

### Problèmes rencontrés précédemment

- **Migrations** : Complexité et lourdeur lors des migrations de base de données.
- **Gestion de la base de données** : Difficultés liées à la maintenance et à l'évolution des schémas de données.
- **Base de code commune** : Gestion des différentes versions du code entre les équipes ou projets.
- **Régression et scalabilité** : Problèmes récurrents lors des tests de régression et des montées en charge.
- **Lenteur due à l'interprétation du code** : Code interprété entraînant une perte de performance.

---

### Solutions techniques

#### DSL (Domain-Specific Language)

Un **DSL** est un langage spécifique au domaine, conçu pour résoudre des problèmes dans un contexte particulier. Dans ce cas, le DSL est utilisé pour définir des modèles de données et générer automatiquement des structures de base pour les API, les modèles, et les interfaces. Il permet de décrire des objets métiers et leurs relations avec des instructions simples et claires.

#### Création d'un compilateur

Le compilateur génère automatiquement les fichiers nécessaires en fonction des modèles définis dans le DSL. Les points clés sont :

- **Pas de base de données** : Les informations sont stockées dans des fichiers texte, éliminant ainsi les migrations complexes.
- **Indépendance des projets** : Chaque projet peut avoir sa propre version du compilateur, garantissant la compatibilité et l'évolution des règles du DSL indépendamment des autres projets.
- **Évolution du DSL** : Le langage peut être étendu au fil du temps pour répondre à de nouveaux besoins.

#### Choix d'OCaml

- **Langage compilé** : Offre des performances élevées grâce à une exécution rapide du code compilé.
- **Syntaxe légère** : Simplifie l'écriture et la lecture du code.
- **Paradigme fonctionnel** : Particulièrement adapté pour la gestion récursive des arbres syntaxiques (AST).
- **Utilisation courante pour l'analyse grammaticale** : OCaml est souvent utilisé pour les outils de compilation et d'interprétation grâce à ses capacités d'analyse syntaxique.

#### Architecture du compilateur

1. **Lexer** : Analyse lexicale qui transforme le code source en une séquence de tokens.
2. **Parser** : Analyse syntaxique qui vérifie la conformité des tokens aux règles de grammaire.
3. **AST (Arbre Syntaxique Abstrait)** : Représentation hiérarchique de la structure du programme pour la génération du code.

---

### Compilation et Exécution

Pour compiler et exécuter ces fichiers, suivez ces étapes :

1. **Générer le fichier `lexer.ml`** :

```bash
ocamllex lexer.mll
```

2. **Compiler les fichiers** :

Pour compiler tout, exécutez simplement :

```bash
make
```

Pour nettoyer les fichiers intermédiaires (comme `.cmo`, `.cmi`), exécutez :

```bash
make clean
```

3. **Lier les fichiers et exécuter** :

```bash
ocamlc -o lexer_program tokens.cmo lexer.cmo main.cmo
./lexer_program
```

Voici une version corrigée et améliorée de votre texte avec plus de clarté et de précision :

---

### Exemple de modèle dans ce DSL

```
model Role [admin, visible] {
    id: uuid [primary, read-only];
    name: string [read-only];  // Les rôles ne peuvent pas être modifiés une fois créés
}

model User [private, visible] {
    id: uuid [primary, read-only];
    name: string;
    email: string [email, read-only];  // L'email est en lecture seule après sa création
    password: string [password];
    role: Role [relation];  // Chaque utilisateur a un rôle
}

model Mission [admin, visible] {
    id: uuid [primary, read-only];
    title: string;
    description: string;
    leader: User [relation, filter: role.name = "Leader", read-only];  // Le leader doit avoir le rôle "Leader"
    status: string [read-only];  // Le statut est en lecture seule et ne peut pas être modifié
}

```

---

### C# .NET

Le compilateur génère automatiquement les composants suivants pour un projet en C# .NET :

- **Modèles** : Génération des classes représentant les modèles.
- **DTOs (Data Transfer Objects)** : Création des objets de transfert de données en fonction des champs visibles.
- **Routes API** : Création des routes de manière procédurale :
  - `GET /all`
  - `POST /{id}`
  - `GET /{id}`
  - `PUT /{id}`
  - `DELETE /{id}`

---

### Angular

Pour un projet Angular, le compilateur génère :

- **DTOs** : Création des objets de transfert de données côté client.
- **Services API** : Création des services pour effectuer les appels API vers le backend.
- **Formulaires** : Génération automatique des formulaires en fonction des modèles définis.
- **Datatables** : Création de tableaux de données interactifs pour la gestion des entités.

---

### GPTs (Assistance à la génération de code)

L'apprentissage d'un nouveau langage peut représenter un coût et un frein pour certains développeurs. Pour faciliter l'adoption du DSL, il serait pertinent de créer un agent GPT spécialisé. Cet agent guiderait les développeurs dans l'utilisation du langage, leur permettant de poser des questions et d'obtenir des suggestions de code en temps réel.

---

### Limitations

Ce DSL n'a pas pour vocation de remplacer les langages existants, mais de simplifier la gestion des **datagrids** et des **formulaires** dans les projets de type "interface de gestion/admin". Il n'est pas conçu pour générer des pages de connexion, des systèmes de messagerie, ou des pages d'accueil complètes. Son objectif principal est d'accélérer la mise en place de projets orientés gestion.

---

### Conclusion

L'introduction d'un DSL spécifique au domaine, associé à un compilateur performant et des outils comme OCaml et GPTs, permet de gagner un temps précieux dans le développement de projets. Il réduit les coûts à long terme en automatisant des tâches récurrentes comme la gestion des bases de données et des API, tout en assurant une scalabilité et une simplicité dans l'évolution des projets.

## Annexes

### Table des valeurs hexadécimales pour les opérations CRUD

Chaque chiffre hexadécimal (de `0` à `F`) représente une combinaison de permissions pour **Create**, **Read**, **Update**, et **Delete** (C, R, U, D) selon la formule suivante :

- **C** (bit 1) : Create → 1
- **R** (bit 2) : Read → 2
- **U** (bit 3) : Update → 4
- **D** (bit 4) : Delete → 8

Les combinaisons possibles sont donc :

| Valeur Hex | CRUD Permissions | Signification                |
| ---------- | ---------------- | ---------------------------- |
| **0**      | ----             | Aucun accès                  |
| **1**      | ---C             | Create                       |
| **2**      | --R-             | Read                         |
| **3**      | --RC             | Create, Read                 |
| **4**      | -U--             | Update                       |
| **5**      | -U-C             | Create, Update               |
| **6**      | -UR-             | Read, Update                 |
| **7**      | -URC             | Create, Read, Update         |
| **8**      | D---             | Delete                       |
| **9**      | D--C             | Create, Delete               |
| **A**      | D-R-             | Read, Delete                 |
| **B**      | D-RC             | Create, Read, Delete         |
| **C**      | DU--             | Update, Delete               |
| **D**      | DU-C             | Create, Update, Delete       |
| **E**      | DUR-             | Read, Update, Delete         |
| **F**      | DURC             | Toutes les opérations (CRUD) |

### Exemple d'utilisation d'un triplé hexadécimal

Pour un triplé hexadécimal de la forme `7E2`, voici ce que cela signifie :

- **7** (pour les administrateurs) :
  - Valeur **7** → **Create, Read, Update** (mais pas Delete) pour les administrateurs.
- **E** (pour les utilisateurs authentifiés) :
  - Valeur **E** → **Read, Update, Delete** (mais pas Create) pour les utilisateurs authentifiés.
- **2** (pour les utilisateurs publics) :
  - Valeur **2** → **Read uniquement** pour les utilisateurs publics.

Ainsi, le triplé **7E2** signifie que :

- Les administrateurs peuvent créer, lire et mettre à jour, mais pas supprimer.
- Les utilisateurs authentifiés peuvent lire, mettre à jour et supprimer, mais pas créer.
- Les utilisateurs publics peuvent seulement lire.
