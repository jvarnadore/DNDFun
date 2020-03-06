class Player  {
   [string]$Name
   [string]$Level
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
   Param($StatRollChoice)
   Process
   {
      Switch ($StatRollChoice)
      {
      ("a" -Or "standard") {
        #Rolls 3 dice and adds the result.
        $DiceResult = (1..6 | Get-Random) + (1..6 | Get-Random) + (1..6 | Get-Random)
        return $DiceResult
        Write-Output "Standard Ran"
        }
      ("b" -Or "generous") {
        #Rolls 4 dice, drops the lowest, and adds the result.
        $DiceArray = (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random)
        $DiceArray = $DiceArray | Sort-Object
        $DiceResult = $DiceArray[$DiceArray.Count-1] + $DiceArray[$DiceArray.Count-2] + $DiceArray[$DiceArray.Count-3]
        return $DiceResult
        Write-Output "Generous Ran"
      }
      ("c" -Or "random Array") {
      $DiceResult = 11
      return $DiceResult
      Write-Output "Array Ran"
      }
      default {
         Write-Output "Sorry that is an invalid option."
      }
   }
   }
   End
   {
      return $DiceResult
   }
}
#Asks for player name and calls for character generation.
Write-Output "Enter your name please"
$($Player.Name = Read-Host)
Write-Output "$($Player.Name), we're going to create your character now."

Write-Output "Now, we'll need to roll you up a character,"
Write-Output "How would you like to roll your stats? A) Standard, B) Generous, or C) Random Array ?"
$StatRollChoice.ToLower() = Read-Host

#Our Stat Block generation function.
$Player.STRStat = Get-Stats
$Player.DEXStat = Get-Stats
$Player.CONStat = Get-Stats
$Player.INTStat = Get-Stats
$Player.WISStat = Get-Stats
$Player.CHAStat = Get-Stats


Write-Output "Alright, here are your character's stats:"
Write-Output "STR: $($Player.STRStat) DEX: $($Player.DEXStat)  CON: $($Player.CONStat) `
INT: $($Player.INTStat) WIS: $($Player.WISStat) CHA: $($Player.CHAStat)" |
Format-Table -AutoSize