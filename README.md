# Redfield Apocalypse

**A feature-rich zombie survival gamemode for Multi Theft Auto: San Andreas (MTA:SA).**

Redfield Apocalypse is a zombie survival gamemode for **Multi Theft Auto: San Andreas**, featuring dynamic zombie encounters, persistent player progression and cooperative gameplay.

The gamemode combines zombie combat, character progression, team management, property ownership, vehicles, an in-game economy, achievements and various additional survival systems into a multiplayer experience.

---

## ✨ Features

### 🧟 Zombie System

Zombies spawn around players outside designated protection zones and automatically attack nearby survivors.

- Dynamic zombie spawning
- Automatic zombie targeting and attacks
- Money and experience rewards for zombie kills
- Random Bonus Point and Safe Key drops
- Increased rewards for Premium players
- Additional experience rewards for nearby team members

### 🛡️ Protection Zones

Protection zones provide safe areas where players can access important services without being attacked by zombies.

- Multiple protection zones throughout the map
- Protection from zombie attacks
- Weapon shops and vehicle access
- NPCs offering shops and information
- Premium protection zone teleportation

### 👤 Accounts & Player Progression

- Account registration and login
- Persistent MySQL player data
- Level and experience system
- Playtime tracking
- Zombie kill and death statistics
- Persistent player progression

### 🔫 Weapons & Weapon Skills

- Level-based weapon purchasing
- Weapon shops in protection zones
- Persistent weapon skills
- Weapon skill progression through combat

### 💰 Economy & Coins

- Money rewards through gameplay
- Bonus Points earned from zombies
- Bonus Point to Coin exchange
- Coin Shop for special purchases
- Skin Shop for character customization
- Premium payday system

### 🎒 Inventory & Items

The inventory can be accessed by pressing **I** and allows players to manage their collected items and currencies.

- Bonus Points
- Chests
- Hearts
- Coins
- Trophies
- Zombie Skin
- Safe Keys
- Health restoration using Hearts
- Zombie Skin activation and removal

### 🔐 Safes

- Safe Keys obtained from zombie drops
- Safes located throughout the gamemode
- Random weapon rewards
- One Safe Key consumed per opening

### 👥 Team System

Players can create their own team for **$50,000** and manage it through the team panel.

- Team creation and management
- Member invitations
- Team ranks and permissions
- Member management
- Shared team cash register
- Shared access to team members' vehicles

### 🏠 Housing & Properties

- Purchasable team houses
- Team-based property ownership
- House spawn locations for team members
- House resale with partial purchase price refunds

### 🚗 Vehicles & Carhouse

- Persistent vehicle purchasing
- Carhouse system
- Vehicle management
- Vehicle parking and locking
- Vehicle location tracking
- Vehicle selling

### 🏆 Achievements & Statistics

- Persistent achievement system
- Zombie kill milestones
- Weapon and vehicle-related achievements
- Trophy rewards
- Player Toplist
- Rankings for levels, zombie kills, Bonus Points, Coins, Trophies and money

### 💎 Premium System

Premium is available through the Coin Shop in two variants:

- 14 Days Premium
- Lifetime Premium

Premium players receive additional benefits, including:

- Increased zombie kill rewards
- Increased ammunition pickups
- Faster weapon skill progression
- Weapon saving functionality
- Hourly payday based on player progression

### 📦 Weapon Depot

- Permanent unlock through the Coin Shop
- Weapon storage
- Ammunition storage
- Retrieval of stored equipment

### 👕 Character Skins

- Purchasable GTA:SA character skins
- Bonus Point-based skin purchases
- Special Zombie Skin available through the Coin Shop

### 🎮 Additional Gameplay Systems

- News system
- Offline messages
- Custom weather and time system

### 🛡️ Administration

- Administration system
- Server management functionality

### 🖥️ User Interface

- Custom HUD
- Scoreboard
- Notifications and infoboxes
- Help menu

---

## ⚙️ Installation

### Requirements

- Multi Theft Auto: San Andreas server
- MySQL database

### Setup

**1. Download the repository**

Clone the repository or download the source code.

**2. Install the resource**

Place the gamemode inside your MTA server's `resources` directory.

```text
resources/
└── RedfieldApocalypse/
```

**3. Set up the database**

Create a MySQL database and import or create the required database tables.

**4. Configure the database connection**

Open the following file:

```text
sMain.lua
```

Update the database connection settings to match your server environment.

**5. Start the resource**

Start the gamemode using your MTA server console.

```text
start RedfieldApocalypse
```

**6. Verify the installation**

Check the server console for errors and ensure that the database connection and required systems are functioning correctly.

---

## 🎬 Media

- **[Watch Gameplay on YouTube](https://youtu.be/lZjxwyfTO1A)**

### Screenshots

A collection of screenshots showcasing the gamemode's survival mechanics, interfaces and gameplay features.

<p align="center">
  <img src="Screenshots/1.png" width="350">
  <img src="Screenshots/2.png" width="350">
  <img src="Screenshots/3.png" width="350">
  <img src="Screenshots/4.png" width="350">
  <img src="Screenshots/5.png" width="350">
  <img src="Screenshots/6.png" width="350">
</p>

<details>
<summary><b>View More Screenshots</b></summary>

<p align="center">
  <img src="Screenshots/7.png" width="350">
  <img src="Screenshots/8.png" width="350">
  <img src="Screenshots/9.png" width="350">
  <img src="Screenshots/10.png" width="350">
  <img src="Screenshots/11.png" width="350">
</p>

</details>

---

## 📊 Project Statistics

| Metric | Count |
|---|---:|
| Lua Files | 55 |
| Additional Files | 95 |
| Functions | 254 |
| Lines | 3,890 |
| Characters | 169,998 |
| Comment Lines | 63 |
| Comment Characters | 1,230 |
