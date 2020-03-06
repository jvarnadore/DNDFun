#Let's start with a Transcript
Start-Transcript -Append -Path $PSCommandPath".txt"

#Starting with a blank slate.
#Set-Display
Clear-Host

class Player  {
   [string]$Name
   [string]$Level
   [string]$Race
   [string]$HitPoints 
   [string]$STRStat
   [string]$DEXStat
   [string]$CONStat
   [string]$INTStat
   [string]$WISStat
   [string]$CHAStat
}
$Player = [Player]::new()

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
#This is the start of the program.
#Set Player.Name variable.
Write-Output "This is the beginning of the game. What is your name?" 
$($Player.Name = Read-Host) | Out-Null
Write-Output "$($Player.Name), we're going to create your character now."

#Prompt for stat generation.
Write-Output "Now, we'll need to roll you up a character,"
Write-Output "How would you like to roll your stats? A) Standard, B) Generous, or C) Random Array?"
$StatRollChoice = Read-Host

$StatRollOptions = "A", "Standard", "B", "Generous", "C", "Random Array", "Random", "Array"

While ($StatRollOptions -notcontains $StatRollChoice) {
   Write-Output "Sorry that is an invalid option. Please select from A) Standard, B) Generous, or C) Random Array"
   $StatRollChoice = Read-Host
}
#Our Stat Block and function scalls.
$Player= Get-Stats -StatRollChoice $StatRollChoice -Player $Player

#Output of Characters stats
Write-Output "Alright, here are your character's stats:"
Write-Output "STR: $($Player.STRStat) DEX: $($Player.DEXStat)  CON: $($Player.CONStat) `
INT: $($Player.INTStat) WIS: $($Player.WISStat) CHA: $($Player.CHAStat)" |
Format-Table -AutoSize