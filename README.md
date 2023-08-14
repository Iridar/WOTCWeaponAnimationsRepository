#  Weapon Animations Repository

WAR is a mod for XCOM 2 War of the Chosen. It stores and applies animations for primary or dual secondaries and other weapons.

The goal is for the mod to eventually succeed the animation portions of Primary Secondaries, Dual Wielded Melee, Dual Pistols and Ballistic Shields, as well as potentially provide animations for new weapon types, like spears. 

The gameplay portions of mentioned mods are to be succeed by other mods.

## List of Animation Sets

Eventually, the mod may contain the following Animation Sets:
- Primary Pistol
- Primary Sword
- Primary Autopistol
- Primary Sawed-off Shotgun
- Dual Pistols
- Dual Swords
- Dual Autopistols
- Dual Sawed-off Shotguns
- Primary Pistol + Ballistic Shield
- Potentially other weapons combined with a Ballistic Shield
- Primary Spear (Glaive)
- Unarmed (hand-to-hand combat)
- Primary Grenade Launcher
- SPARK Primary Sword
- SPARK Primary Warhammer

### Animation Set Contents

Ideally, each Animation Set should include the following animations:
- Full set of tactical animations.
- Skyranger animations - for dropping off Skyranger at the mission start.
- Shell animations - when the soldier is standing behind the main menu after the game starts.
- Armory animations - three animations for each of the 11 attitudes: walk to camera, idle, walk away from camera.
- Photobooth poses.
- Misc animations: things like running off the Avenger's apparel during Avenger Defense mission.

## Planned Functionality

The mod is intended to be a foundation that can be used as a dependency by other mods without the fear of conflicts, but also as a something that can work with the minimal amount of setup.

**What this mod WILL do:**

1) Detect weapons equipped by a unit, and apply appropriate animations automatically.

Which weapons should use what animations will be determined by this mod based on configuration.

The default configuration will handle the vanilla weapon categories. Mods that add new weapon categories will have to provide compatibility config. 

Before giving the new animation sets to a unit, the mod will trigger an event that can be used by other mods to override which animation sets should be applied to this particular unit.

2) Allow soldiers to equip secondary weapons into their primary weapon slot, if this is allowed by their soldier class.

The general idea here is that a mod that adds a soldier class that wants to use, say, a primary pistol, can set up the soldier class, set the pistol as an allowed primary weapon, assign the class abilities to the primary weapon slot, including Standard Pistol Shot, which is not located on the pistols' weapon template normally, then mark the WAR as the required mod and it will just work seamlessly.

WAR will not decide for that soldier class whether their primary pistol should deal different damage compared to secondary pistols, or whether it should have finite ammo.

**What this mod will NOT do:**

1) Allow soldier classes that normally do not use primary / dual secondaries to do so. (As Primary Secondaries / Dual Pistols mods do)
2) Grant or reassign soldier class abilities based on their equipment. (As Ability to Slot Reassignment / RPGO / Dual Pistols do)
3) Make any changes to any existing abilities or weapons.

These should be handled by a different mod, most likely a sibling mod project.
