# Constants
$Filename = "$HOME\.ggd_dirs.txt"

# Function to display help
function Show-Help
{
  Write-Host "ggd - Go to Directory"
  Write-Host "Usage: ggd [a|r|l|c|?]"
  Write-Host "  a - Add current directory to ggd"
  Write-Host "  r - Remove directory from ggd"
  Write-Host "  l - List directories in ggd"
  Write-Host "  c - Clear all directories from ggd"
  Write-Host "  ? - Show help"
  Write-Host "  No arguments - Change directory using fzf"
}

# Function to clear all directories from .ggd_dirs.txt
function Clear-GgdDirs
{
  Clear-Content $Filename
}

# Function to Add Directory
function Add-GgdDir
{
  param([string]$Dir)
  # Check if exists
  if ($null -eq (Get-Content $Filename | Where-Object { $_.Trim() -eq $Dir.Trim() }))
  {
    $Dir | Out-File -FilePath $Filename -Append -Encoding UTF8
  }
}

# Function to Remove Directory
function Remove-GgdDir
{
  param([string]$DirToRemove)
  # Load dirs, filter, then save
  $Directories = Get-Content $Filename | Where-Object { $_.Trim() -ne $DirToRemove.Trim() }
  $Directories | Out-File -FilePath $Filename -Encoding UTF8
}

# Function to List Directories (Basic)
function Get-GgdDirs
{
  $dirs = @()  # Create an empty array
  Get-Content $Filename | ForEach-Object {
    $trimmed = $_.Trim()
    if ($trimmed)
    {  # Check if the trimmed line is not empty
      $dirs += $trimmed  # Add the trimmed line to the array
    }
  }
  return $dirs  # Return the array
}

# Function to Change Directory
function Set-GgdDir
{
  param([string]$Dir)
  Set-Location $Dir
}

# --- Main Logic ---

# 'ggd a' (Add)
if ($args[0] -eq "a")
{
  $CurrentDir = Get-Location
  Add-GgdDir -Dir $CurrentDir
  Write-Host "Added $CurrentDir to ggd."
}
# 'ggd r' (Remove) - use fzf
elseif ($args[0] -eq "r")
{
  $Directories = Get-GgdDirs
  if (($Directories -is [array] -and $Directories.Count -gt 0) -or
        ($Directories -is [string] -and $Directories.Length -gt 0))
  {

    # Use fzf to select a directory
    $selectedDir = $Directories | fzf --color="fg:#d0d0d0,bg:#303030,hl:#5f87af" --prompt="Select directory: > "

    if ($selectedDir)
    {
      Remove-GgdDir -Dir $selectedDir
      Write-Host "Removed $selectedDir"
    }
  } else
  {
    Write-Host "No directories in ggd."
  }
}
# 'ggd l' (List)
elseif ($args[0] -eq "l")
{
  $Directories = Get-GgdDirs
  if (($Directories -is [array] -and $Directories.Count -gt 0) -or
        ($Directories -is [string] -and $Directories.Length -gt 0))
  {
    foreach ($dir in $Directories)
    {
      Write-Output $dir
    }
  } else 
  {
    Write-Host "No directories in ggd."
  }
}
# 'ggd c' (clear)
elseif ($args[0] -eq "c")
{
  Clear-GgdDirs
  Write-Host "Cleared all directories from ggd."
}
# 'ggd ?' (help)
elseif ($args[0] -eq "?")
{
  Show-Help
}
# No Args (List and Change) - use fzf
else
{
  $Directories = Get-GgdDirs
  if (($Directories -is [array] -and $Directories.Count -gt 0) -or
        ($Directories -is [string] -and $Directories.Length -gt 0))
  {

    # Use fzf to select a directory
    $selectedDir = $Directories | fzf --color="fg:#d0d0d0,bg:#303030,hl:#5f87af" --prompt="Select directory: > "

    if ($selectedDir)
    {
      Set-GgdDir -Dir $selectedDir
    }
  } else
  {
    Write-Host "No directories in ggd."
  }
}
