Scriptname MEKCHJModInitializationScript extends ReferenceAlias  
{Copyright 2021 Mark E. Kraus
Adds cheat powers to the player on the next game load.}

FormList Property MEKCHPAllJewelry  Auto
{FormList of Items to add to the player}

FormList Property MEKCHPAllPowers  Auto
{Array of powers to add to the player}

Bool Property Initialized = false Auto

string LogPrefix = "[MEKCHJ] "

Event OnInit()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    Maintenance()
EndEvent

Function TraceLog(string logEntry)
    Debug.Trace(LogPrefix + logEntry)
EndFunction

Function Maintenance()
    TraceLog("=================Maintenance Start=================")
    If (!Initialized)
        Initialized = true
        AddCheatJewelry()
        AddPowers()
    EndIf
    TraceLog("=================Maintenance End===================")
EndFunction

Function AddCheatJewelry()
    Actor player = Game.GetPlayer()
    int index = 0
    While (index < MEKCHPAllJewelry.GetSize())
        Form curForm = MEKCHPAllJewelry.GetAt(index)
        if (!player.GetItemCount(curForm))
            TraceLog("Adding '" + curForm + "' to player.")
            player.AddItem(curForm)
        EndIf
        index += 1
    EndWhile
EndFunction

Function AddPowers()
    Actor player = Game.GetPlayer()
    int index = 0
   While (index < MEKCHPAllPowers.GetSize())
       Spell curSpell = MEKCHPAllPowers.GetAt(index) as Spell
       If (!Player.HasSpell(curSpell))
           Player.AddSpell(curSpell)
       EndIf
       index += 1
   EndWhile
EndFunction
