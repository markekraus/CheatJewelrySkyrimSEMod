Scriptname MarkekrausAddCheatRingsScript extends Quest  
{Copyright 2021 Mark E. Kraus
Adds Items to the player}

Armor[] Property Rings Auto

Event OnInit()
    Actor player = Game.GetPlayer()
    int index = 0
    While (index < Rings.Length)
        Armor curRing = Rings[index]
        if player.AddItem(curRing)
        EndIf
        index += 1
    EndWhile
EndEvent