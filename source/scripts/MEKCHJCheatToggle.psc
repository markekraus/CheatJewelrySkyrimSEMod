Scriptname MEKCHJCheatToggle extends ActiveMagicEffect  
{Copyright 2022 Mark E. Kraus
Toggles various cheats when rings are equiped and unequiped}

String Property Cheat  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    If (Cheat == "collisions")
        Debug.ToggleCollisions()
    EndIf
    If (Cheat == "godmode")
        Debug.SetGodMode(true)
    EndIf
    If (Cheat == "aidetect")
        ConsoleUtil.ExecuteCommand("TDetect")
    EndIf
    If (Cheat == "freecam")
        Utility.Wait(1.0)
        ConsoleUtil.ExecuteCommand("tfc 1")
    EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    If (Cheat == "collisions")
        Debug.ToggleCollisions()
    EndIf
    If (Cheat == "godmode")
        Debug.SetGodMode(false)
    EndIf
    If (Cheat == "aidetect")
        ConsoleUtil.ExecuteCommand("TDetect")
    EndIf
    If (Cheat == "freecam")
        Utility.Wait(1.0)
        ConsoleUtil.ExecuteCommand("tfc")
    EndIf
EndEvent