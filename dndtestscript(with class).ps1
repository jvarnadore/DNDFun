#Let's start with a Transcript
Start-Transcript -Append -Path $PSCommandPath".txt"

#Function Block
#Function to generate stats.

    

#Starting with a blank slate.
#Set-Display
Clear-Host
Write-Host "This is the beginning of the game. What is your name?" 

#Define our player format.
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


#Asks for player name and calls for character generation.
$Player.Name = Read-Host
Write-Output "$($Player.Name), we're going to create your character now."

Write-Output "Now, we'll need to roll you up a character,"
Write-Output "How would you like to roll your stats? A) Standard, B) Generous, or C) Random Array ?"
$StatRollChoice = Read-Host

if($StatRollChoice -eq "C" -Or $StatRollChoice -eq "Random Array")
{
    #Assigns the standard array, randomly.
    $Player.STRStat = 11
    $Player.DEXStat = 11
    $Player.CONStat = 11
    $Player.INTStat = 11
    $Player.WISStat = 11
    $Player.CHAStat = 11
}else {
Switch ($StatRollChoice)
{
    ("A" -Or "Standard") {function Get-Stats 
        {
        [cmdletbinding()]Param()
        #Rolls 3 dice and adds the result.
        $DiceResult = (1..6 | Get-Random) + (1..6 | Get-Random) + (1..6 | Get-Random)
        return $DiceResult
        }}
    ("B" -Or "Generous") {function Get-Stats {
        [cmdletbinding()]Param()
        #Rolls 4 dice, drops the lowest, and adds the result.
        $DiceArray = (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random), (1..6 | Get-Random)
        $DiceArray = $DiceArray | Sort-Object
        $DiceResult = $DiceArray[$DiceArray.Count-1] + $DiceArray[$DiceArray.Count-2] + $DiceArray[$DiceArray.Count-3]
        return $DiceResult
    }}

    Dim {function Get-Stats {
        [cmdletbinding()]Param()
        #A special option for Dim
        $Mayo = 3
        $DiceResult = $Mayo
        return $DiceResult

    }}
    Anything {Write-Output "I'm sorry that's not an available choice."}
}
#Our Stat Block generation function.
$Player.STRStat = Get-Stats
$Player.DEXStat = Get-Stats
$Player.CONStat = Get-Stats
$Player.INTStat = Get-Stats
$Player.WISStat = Get-Stats
$Player.CHAStat = Get-Stats
}

Write-Output "Alright, here are your character's stats:"
Write-Output "STR: $($Player.STRStat) DEX: $($Player.DEXStat)  CON: $($Player.CONStat) `
INT: $($Player.INTStat) WIS: $($Player.WISStat) CHA: $($Player.CHAStat)" |
Format-Table -AutoSize
#Read-Host -Prompt "Press Enter to Exit"

Stop-Transcript | Out-Null