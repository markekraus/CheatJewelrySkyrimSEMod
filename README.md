# Cheat Jewelry

![Cheat Jewelry](logo.png)

A Skyrim Special Edition mod By Mark E. Kraus.

My mods:

* [Barstool Brawler](https://www.nexusmods.com/skyrimspecialedition/mods/61354)
* [Chairhammers - Chair Warhammers](https://www.nexusmods.com/skyrimspecialedition/mods/61304)
* [Chairrows - Chair Arrows](https://www.nexusmods.com/skyrimspecialedition/mods/61168)
* [Cheat Jewelry](https://www.nexusmods.com/skyrimspecialedition/mods/58973)
* [Cheat Powers](https://www.nexusmods.com/skyrimspecialedition/mods/58892)
* [Exit Combat Power](https://www.nexusmods.com/skyrimspecialedition/mods/58651)
* [Sentient Chairs of Skyrim (SCOS)](https://www.nexusmods.com/skyrimspecialedition/mods/59604)

## About Cheat Jewelry

This mod adds several amulets, circlets, and rings that work as shortcuts to common console command cheats.

## Jewelry

Each of the following has their own amulet, circlet, and ring.

* Cheat: Toggle AI Detection - Toggles NPCs' ability to detect the player.
* Cheat: Toggle Collision - Toggles collision for the player. This allows the player to walk through walls, doors, floors, etc.
* Cheat: Toggle Free Camera - Toggles Free Camera mode. This freezes NPCs and the environment allowing the player camera to move freely to take screenshots or look around.
* Cheat: Toggle God Mode - Toggles God Mode on or off.

## Powers

This mod also adds a "Cheat: Add Cheat Jewelry" power to your spells list. This will add any missing cheat jewelry to your inventory. It will not add duplicates of existing cheat jewelry already in your inventory.

## Manual Upgrading from 1.0.0 to 2.0.0 or later

If you manually installed version 1.0.0 of this mod (this does not apply to Mod Organizer 2, Vortex, or other mod managers), before updating to 2.0.0, you will need to do the following:

* Disable the `MarkekrausCheatJewelry.esl` plugin using whatever method you usually use.
* Open the `Data` folder under your Skyrim: Special Edition installation folder.
* Delete `MarkekrausCheatJewelry.esl`.
* In `Scripts` under `Data` delete `MarkekrausAddCheatRingsScript.pex` and `MarkekrausRingCheatToggle.pex`.
* In `Source\Scripts` delete `MarkekrausAddCheatRingsScript.psc` and `MarkekrausRingCheatToggle.psc` (if present).
* Follow the install directions to complete upgrade.

The files to delete are:

* `Data\MarkekrausCheatJewelry.esl`
* `Data\Scripts\MarkekrausAddCheatRingsScript.pex`
* `Data\Scripts\MarkekrausRingCheatToggle.psc`
* `Data\Source\Scripts\MarkekrausAddCheatRingsScript.psc`
* `Data\Source\Scripts\MarkekrausRingCheatToggle.psc`

## Installation

### Requirements

[ConsoleUtilSSE](https://www.nexusmods.com/skyrimspecialedition/mods/24858) must be installed before installing this mod.
[SKSE64](https://skse.silverlock.org/) must be installed before installing this mod.

### NMM/Vortex

Download and install with Vortex and the FOMOD installer will take care of the rest.

### Manual

* Extract the Zip file.
* Copy the extracted `MarkekrausCheatJewelry.esp` and `MarkekrausCheatJewelry.bsa` files to the `data` folder under your Skyrim: Special Edition installation folder.
* Enable the plugin using whatever method you usually use.

## User Guide

The cheat jewelry will be automatically added to your inventory. Items > Armor. Equip the desired amulets, circlets, and/or rings and the cheat(s) will be applied.

Wearing 2 of the same effect (e.g. wearing both the God Mode amulet and ring) will result in strange behavior. Each slot should be a unique cheat.

If you accidentally sell, drop, or otherwise lose the jewelry, you can re-add them to your inventory using the "Cheat: Add Cheat Jewelry" power.

## Compatibility

This mod should be compatible with everything and should not require any patches.

## Warning: Not Lore-Friendly and Cheating

This mod is definitely not lore-friendly.

This mod is made for cheating.
