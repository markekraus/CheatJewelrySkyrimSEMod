Scriptname MarkekrausRingCheatToggle extends ActiveMagicEffect  
{Copyright 2021 Mark E. Krais
Toggles various cheats when rings are equiped and unequiped}

String Property Cheat  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
    If (Cheat == "collisions")
        ;
    EndIf
    If (Cheat == "godmode")
        Debug.SetGodMode(true)
    EndIf
    If (Cheat == "aidetect")
        ;
    EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    If (Cheat == "collisions")
        ;
    EndIf
    If (Cheat == "godmode")
        Debug.SetGodMode(false)
    EndIf
    If (Cheat == "aidetect")
        ;
    EndIf
EndEvent