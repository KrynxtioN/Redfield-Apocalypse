# Redfield Apocalypse

Redfield Apocalypse is a zombie survival gamemode for Multi Theft Auto: San Andreas (MTA:SA), developed in Lua.

The gamemode combines zombie survival with persistent player progression, teams, houses, vehicles, achievements, weapons, an economy system and various additional gameplay systems.

## 🧟 Zombie System

Zombies spawn around players outside of protection zones and attack nearby survivors.

Killing zombies rewards players with money and experience points. Zombies also have a chance to drop Bonus Points and Safe Keys, which can be used in other systems throughout the gamemode.

Premium players receive increased money and experience rewards for killing zombies.

## 🛡️ Protection Zones

Protection zones are safe areas where players are protected from zombies.

Multiple protection zones are located throughout the map and contain important locations such as weapon shops and vehicles. The main protection zone also contains NPCs that provide access to additional shops and information.

## 👤 Accounts & Progression

Redfield Apocalypse includes its own registration and login system with MySQL persistence.

Player progress is permanently stored, including:

* Money and Coins
* Level and experience
* Playtime
* Zombie kills and deaths
* Bonus Points
* Hearts and Trophies
* Safe Keys
* Premium status
* Team and team rank
* Weapon skills
* Zombie Skin

## ⭐ Level System

Players earn experience points by killing zombies and through other systems within the gamemode.

The experience required for the next level increases as the player progresses. Higher levels are also required to purchase stronger weapons from the weapon shops.

Players can additionally receive experience when killing zombies together with nearby team members.

## 🔫 Weapons & Weapon Skills

Weapon shops are located inside the protection zones and offer different weapons depending on the player's level.

Redfield Apocalypse also includes persistent weapon skills. Weapon skills increase while using the corresponding weapons and are saved together with the player's progress.

## 💰 Economy & Coins

Players earn money through gameplay and can spend it on weapons, vehicles, teams and other systems.

The gamemode also includes Bonus Points and Coins. Bonus Points can be obtained from zombies and exchanged for Coins, while Coins are used for special purchases in the Coin Shop.

## 🎒 Inventory

The inventory can be opened by pressing **I** and contains the player's collected items and currencies.

The inventory includes Bonus Points, Chests, Hearts, Coins, Trophies, the Zombie Skin and Safe Keys. Hearts can be used to restore health, while the Zombie Skin can be equipped or removed directly through the inventory.

## 🔐 Safes

Safe Keys can occasionally be obtained by killing zombies.

These keys can be used to open safes located throughout the gamemode. Opening a safe consumes one key and rewards the player with a random weapon.

## 👥 Team System

Players can create their own team for **$50,000** and manage it through the team panel.

The team system includes member invitations, different ranks, member management and a team cash register. Team members can also benefit from additional systems such as shared vehicle access and team houses.

## 🏠 Houses

Teams can purchase houses located throughout the map.

Owned houses are connected to the team and can be used as a spawn location for its members. Houses can also be sold again, returning part of their original purchase price.

## 🚗 Vehicles & Carhouse

Players can purchase persistent vehicles through the Carhouse.

Owned vehicles can be managed through the vehicle system, including parking, locking, locating and selling them. Team members can also use vehicles belonging to other members of their team.

## 🏆 Achievements

Redfield Apocalypse includes a persistent achievement system that rewards players for reaching different milestones.

Achievements include objectives such as killing zombies, purchasing a weapon, using a vehicle and reaching larger zombie kill milestones. Completed achievements reward the player with Trophies.

## 💎 Premium System

Premium can be purchased through the Coin Shop as either **14 days of Premium** or **Lifetime Premium**.

Premium players receive several additional benefits, including increased zombie rewards, increased ammunition pickups, faster weapon skill progression, weapon saving and access to protection zone teleports.

Premium players also receive an hourly payday based on their current progression.

## 📦 Weapon Depot

The Weapon Depot can be permanently unlocked through the Coin Shop.

It allows players to store weapons and ammunition and retrieve them again later.

## 👕 Skin System

Players can purchase character skins through the Skin Shop using Bonus Points.

A separate Zombie Skin can be purchased through the Coin Shop and activated directly through the inventory.

## 📊 Toplist

The gamemode includes a Toplist where players can compare different progression values and statistics.

Tracked values include Level, Zombie Kills, Bonus Points, Coins, Trophies and Money.

## 🎲 Additional Systems

Redfield Apocalypse includes several additional systems beyond the main zombie survival gameplay:

* Custom HUD and scoreboard
* Custom notifications and infoboxes
* Weapon shops
* Skin shop
* Coin shop
* Payday system
* Inventory system
* Weapon Depot
* Weapon skills
* Vehicle system
* Carhouse
* Team system
* House system
* Achievement system
* Toplist
* News system
* Offline messages
* Help menu
* Administration system
* Custom weather and time system

## ⚙️ Installation

1. Place `RedfieldApocalypse` inside your MTA server's `resources` directory.
2. Create/import the required database tables.
3. Configure the database connection for your environment (sMain.lua).
4. Start the resource on your MTA server.

## 🎬 Media

* https://youtu.be/lZjxwyfTO1A

<p align="center">
  <img src="Screenshots/1.png" width="350">
  <img src="Screenshots/2.png" width="350">
  <img src="Screenshots/3.png" width="350">   
  <img src="Screenshots/4.png" width="350">
  <img src="Screenshots/5.png" width="350">
  <img src="Screenshots/6.png" width="350">   
  <img src="Screenshots/7.png" width="350">
  <img src="Screenshots/8.png" width="350">
  <img src="Screenshots/9.png" width="350">
  <img src="Screenshots/10.png" width="350">
  <img src="Screenshots/11.png" width="350">   
  <img src="Screenshots/12.png" width="350">
  <img src="Screenshots/13.png" width="350">
  <img src="Screenshots/14.png" width="350">   
  <img src="Screenshots/15.png" width="350">
  <img src="Screenshots/16.png" width="350">
  <img src="Screenshots/17.png" width="350">
  <img src="Screenshots/18.png" width="350">
  <img src="Screenshots/19.png" width="350">   
  <img src="Screenshots/20.png" width="350">
  <img src="Screenshots/21.png" width="350">
</p>

## 📊 Statistics

| Category           | Amount |
| ------------------ | -----: |
| LUA files          |      55 |
| other files        |      95 |
| functions          |      254 |
| lines              |      3890 |
| characters         |      169998 |
| comment-lines      |      63 |
| comment-characters |      1230 |
