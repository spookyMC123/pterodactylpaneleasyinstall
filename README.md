## 🐉 Pterodactyl Panel Docker Installer

This script installs the **Pterodactyl Panel** using Docker and Docker Compose in a simple and automated way.

> ⚠️ Made by **Joy**

github or ect install 1/-

first cmd not working then 2/-

codesandbox 3/-

or cmd 4/-

---
1/-
#install panell [recommended]
```plaintext 
bash <(curl -s https://raw.githubusercontent.com/spookyMC123/pterodactylpaneleasyinstall/refs/heads/main/ptero.se)
```
2/-
#use only uper command not working install panel
```plaintext
bash <(curl -s https://raw.githubusercontent.com/spookyMC123/pterodactylpaneleasyinstall/refs/heads/main/tryptero.sh)
```
3/-
#codesandbox vps
```plaintext
bash <(curl -s https://raw.githubusercontent.com/spookyMC123/pterodactylpaneleasyinstall/refs/heads/main/codesandboxptero.sh)
```
#or
4/-
#install
```plaintext 
git clone https://github.com/spookyMC123/pterodactylpaneleasyinstall.git
```
#then
```plaintext 
cd pterodactylpaneleasyinstall
```
#run command vc
```plaintext 
chmod +x ptero.se
```
#run command
```plaintext
./ptero.se
or
bash ptero.se
```




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
