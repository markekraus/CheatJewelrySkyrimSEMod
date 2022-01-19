Scriptname MEKCHJAddCheatJewelryScript extends ActiveMagicEffect

MEKCHJModInitializationScript Property InitScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    InitScript.AddCheatJewelry()
EndEvent
