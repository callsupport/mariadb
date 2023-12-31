#!/bin/bash

# Demander le nom du projet à l'utilisateur
read -p "Veuillez entrer le nom du projet : " project_name

# Installer MariaDB si nécessaire
if ! [ -x "$(command -v mariadb)" ]; then
    sudo apt update
    sudo apt install mariadb-server -y
fi

# Créer la base de données avec le nom du projet
sudo mariadb -e "CREATE DATABASE $project_name;"

# Générer un mot de passe aléatoire de 16 caractères
password=$(openssl rand -base64 16)

# Créer un utilisateur avec le nom du projet et le mot de passe aléatoire
sudo mariadb -e "CREATE USER '$project_name'@'localhost' IDENTIFIED BY '$password';"

# Accorder tous les droits à l'utilisateur sur la base de données
sudo mariadb -e "GRANT ALL PRIVILEGES ON $project_name.* TO '$project_name'@'localhost';"

# Afficher les informations récapitulatives
echo "Base de données $project_name créée avec succès."
echo "Nom d'utilisateur : $project_name"
echo "Mot de passe : $password"
