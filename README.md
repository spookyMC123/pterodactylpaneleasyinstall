#install panell
```plaintext 
bash <(curl -s https://github.com/spookyMC123/pterodactylpaneleasyinstall/main/ptero.se)
```
run command
```plaintext 
chmod +x ptero.se
./install_pterodactyl.sh

```



# 🐉 Pterodactyl Panel Docker Installer

This script installs the **Pterodactyl Panel** using Docker and Docker Compose in a simple and automated way.

> ⚠️ Made by **Joy**

---

## 📦 What It Does

- Creates the directory structure: `pterodactyl/panel`
- Generates a `docker-compose.yml` file with:
  - MariaDB as the database
  - Redis as cache
  - Pterodactyl Panel container
- Starts all services with `docker-compose`
- Prompts you to create an admin user

---

## 🛠️ Requirements

Make sure the following are installed before running the script:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

You can install Docker on Ubuntu via:

```bash
sudo apt update && sudo apt install docker.io docker-compose -y
🚀 How to Use
Clone or copy the script to your system.

Make the script executable:

🌐 Access Panel
After setup, access the panel at: port:80

Or your server's IP address in a browser.

📁 Directory Structure
markdown
Copy
Edit
pterodactyl/
└── panel/
    └── docker-compose.yml
📬 Contact
For help, contact Joy or open an issue if this is in a GitHub repo.
**email:rakibuljoy90@gmail.com**

---

made by joy c InfinityForge
