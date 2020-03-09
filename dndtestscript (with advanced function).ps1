#Let's start with a Transcript
Start-Transcript -Append -Path $PSCommandPath".txt"

#Starting with a blank slate.
#Set-Display
Clear-Host

#Create "Race" class and fill in our core 5e races.
class Race {
   [string]$Name
   [string]$Stats
   [string]$Feats
   [string]$Desc
}

$Dragonborn = [Race]::new()
   $Dragonborn.Name = "Dragonborn"
   $Dragonborn.Stats = "+2 STR +1 CHA"
   $Dragonborn.Feats = "Draconic Ancestry, Breath Weapon, Damage Resistance"
   $Dragonborn.Desc = "Dragonborn look very much like dragons standing erect in humainoid form, though they lack wings or a tail."

$Dwarf = [Race]::new()
   $Dwarf.Name = "Dwarf"
   $Dwarf.Stats = "+2 CON"
   $Dwarf.Feats = "Darkvision, Dwarven Resilience, Dwarven Combat Training, Stonecunning"
   $Dwarf.Desc = "Bold and hard, dwarves are known as skilled warriors, miners, and workers of stone and metal."

$Elf = [Race]::new()
   $Elf = "Elf"
   $Elf.Stats = "+2 DEX"
   $Elf.Feats = "Darkvision, Keen Senses, Fey Ancestry, Trance"
   $Elf.Desc = "Elves are a magical people of otherwordly grace, living in the world but not entirely part of it."

$Gnome = [Race]::new()
   $Gnome = "Gnome"
   $Gnome.Stats =
   $Gnome.Feats =
   $Gnome.Desc =

$HalfElf = [Race]::new()
   $HalfElf = "Half elf"
   $HalfElf.Stats =
   $HalfElf.Feats =
   $HalfElf.Desc =

$Halfling = [Race]::new()
   $Halfling = "Halfling"
   $Halfling.Stats =
   $Halfling.Feats =
   $Halfling.Desc =

$HalfOrc = [Race]::new()
   $HalfOrc = "Half orc"
   $HalfOrc.Stats =
   $HalfOrc.Feats =
   $HalfOrc.Desc =

$Human = [Race]::new()
   $Human = "Human"
   $Human.Stats =
   $Human.Feats =
   $Human.Desc =

$Tiefling = [Race]::new()
   $Tiefling = "Tiefling"
   $Tiefling.Stats =
   $Tiefling.Feats =
   $Tiefling.Desc =

#Create our "Player" class and call for the creation of our first player.

class Player  {
   [string]$Name
   [string]$Level
   [string]$Race
   [string]$Racials
   [string]$HitPoints 
   [string]$STRStat
   [string]$DEXStat
   [string]$CONStat
   [string]$INTStat
   [string]$WISStat
   [string]$CHAStat
}
$Player = [Player]::new()

#Function that is called when the player chooses how to roll their stats.
function Get-Stats
{
   [CmdletBinding()]
   Param(
      $StatRollChoice,
      $Player)

      $StandardChoice = "A", "Standard"
      $GenerousChoice = "B", "Generous"
      $ArrayChoice    = "C", "Array", "Random", "Random Array"
      $Abilities = "STRStat", "DEXStat", "CONStat", "INTStat", "WISStat", "CHAStat"
         ForEach ($Ability in $Abilities){
            Switch ($StatRollChoice)
               {
               {$StandardChoice -contains $_} {
                  #Rolls 3 dice and adds the result.
               $DiceResult = (1..6 | Get-Random) + (1..6 | Get-Random) + (1..6 | Get-Random)
               $Player.$Ability = $DiceResult
               }
               {$GenerousChoice -contains $_} {
               #Rolls 4 dice, drops the lowest, and adds the result.
               $DiceArray = (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random)
               $DiceArray = $DiceArray | Sort-Object
               $DiceResult = $DiceArray[$DiceArray.Count-1] + $DiceArray[$DiceArray.Count-2] + $DiceArray[$DiceArray.Count-3]
               $Player.$Ability = $DiceResult
               }
               {$ArrayChoice -contains $_} {
               $DiceResult = 11
               $Player.$Ability = $DiceResult
               }
               default {
                  Write-Output "Sorry that is an invalid option."
               }
            }
         }
         return $Player
}

#This function adjusts the players stats for their selected race.
function Add-Stats-Race {
   [CmdletBinding()]
   Param($Player)

   $HalfOrc = "Half-Orc", "Half Orc"
   $HalfElf = "Half-Elf", "Half Elf"

   switch ($Player.Race){
      {
         Dragonborn {$Player.STRStat = $Player.STRStat + 2}


      }
      }

}


#This is the start of the program.
#Set Player.Name variable.
Write-Output "This is the beginning of the game. What is your name?" 
$($Player.Name = Read-Host) | Out-Null
Write-Output "$($Player.Name), we're going to create your character now."

#Prompt for stat generation.
Write-Output "First, we'll need to decide your stats, How would you like to roll your stats?"
Write-Output "We have three options: A) Standard, B) Generous, or C) Random Array?" 

$StatRollChoice = Read-Host

$StatRollOptions = "A", "Standard", "B", "Generous", "C", "Random Array", "Random", "Array"

#Comapre choice against valid stat roll options and repeat if invalid.
While ($StatRollOptions -notcontains $StatRollChoice) {
   Write-Output "Sorry that is an invalid option. Please select from A) Standard, B) Generous, or C) Random Array"
   $StatRollChoice = Read-Host
}

#Prompt for race selection.
Write-Output "Next we'll need to pick your race from the core Dungeons and Dragons 5th Edition rules:"
$Player.Race = Read-Host

$RaceOptions = "Dragonborn", "Dwarf", "Elf", "Gnome", "Half-elf", "Half Elf", "Hafling", "Half-Orc", "Half Orc", "Human", "Tiefling"

#Compare choice against valid race options and repeat if invalid.
While ($RaceOptions -notcontains $Player.Race) {
   Write-Output "Sorry that is an invalid option. Please select a valid option from: Dragonborn, Dwarf, Elf, Gnome, Half-Elf, Halfing, Half-Orc, Human, or Tiefling"
}

#Our Stat Block, function scalls, and setting default player level to 1.
$Player.Level = 1
$Player= Get-Stats -StatRollChoice $StatRollChoice -Player $Player

#Call function to adjust stats based on race.

Adjust-Stats-Race -Player $Player 

#Output of Characters stats
Write-Output "Alright, here are your character's sheet:"
Write-Output "Name: $($Player.Name)"
Write-Output "Level: $($Player.Level)"
Write-Output "Race: $($Player.Race)"
Write-Output "STR: $($Player.STRStat) DEX: $($Player.DEXStat)  CON: $($Player.CONStat) `
INT: $($Player.INTStat) WIS: $($Player.WISStat) CHA: $($Player.CHAStat)" |
Format-Table -AutoSize