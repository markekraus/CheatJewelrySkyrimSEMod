Scriptname MEKCHJModInitializationScript extends ReferenceAlias  
{Copyright 2021 Mark E. Kraus
Adds cheat powers to the player on the next game load.}

FormList Property MEKCHPAllJewelry  Auto
{Array of powers to add to the player}

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
    TraceLog("=================Maintenance End===================")
EndFunction
