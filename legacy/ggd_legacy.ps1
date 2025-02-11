# PowerShell Script (ggd.ps1)

# Constants
$Filename = "$HOME\.ggd_dirs.txt"

# Function to Add Directory
function Add-GgdDir
{
  param([string]$Dir)
  # Check if exists
  if ((Get-Content $Filename | Where-Object { $_.Trim() -eq $Dir.Trim() }) -eq $null)
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
function List-GgdDirs
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
function Change-GgdDir
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
# 'ggd r' (Remove) - Basic example using Read-Host, but a GUI would be better here.
elseif ($args[0] -eq "r")
{
  $Directories = List-GgdDirs
  # Write-Host "DEBUG (ggd r): \$Directories = $($Directories)"
  # Write-Host "DEBUG (ggd r): \$Directories is array: $($Directories -is [array])"
  # Write-Host "DEBUG (ggd r): \$Directories.Count = $($Directories.Count)"

  if (($Directories -is [array] -and $Directories.Count -gt 0) -or
        ($Directories -is [string] -and $Directories.Length -gt 0))
  {
    Write-Host "Directories:"
    # Handle the case where $Directories is a string (single directory)
    if ($Directories -is [string])
    {
      Write-Host "1: $($Directories)"
      $Choice = Read-Host "Enter number to remove"
      if ($Choice -eq "1")
      {
        Remove-GgdDir -Dir $Directories
      }
    }
    # Handle the case where $Directories is an array
    else
    {
      for ($i = 0; $i -lt $Directories.Count; $i++)
      {
        Write-Host "$($i+1): $($Directories[$i])"
      }
      $Choice = Read-Host "Enter number to remove"
      if ($Choice -match "^\d+$" -and $Choice -ge 1 -and $Choice -le $Directories.Count)
      {
        Remove-GgdDir -Dir $Directories[$Choice-1]
      }
    }
  } else
  {
    Write-Host "No directories in ggd."
  }

}
# No Args (List and Change) - A more advanced menu/GUI would be appropriate here
else
{
  $Directories = List-GgdDirs
  # Write-Host "DEBUG (ggd): \$Directories = $($Directories)"
  # Write-Host "DEBUG (ggd): \$Directories is array: $($Directories -is [array])"
  # Write-Host "DEBUG (ggd): \$Directories.Count = $($Directories.Count)"

  if (($Directories -is [array] -and $Directories.Count -gt 0) -or
        ($Directories -is [string] -and $Directories.Length -gt 0))
  {
    Write-Host "Directories:"

    # Handle the case where $Directories is a string (single directory)
    if ($Directories -is [string])
    {
      Write-Host "1: $($Directories)"
      $Choice = Read-Host "Enter number to change to"
      if ($Choice -eq "1")
      {
        Change-GgdDir -Dir $Directories
      }
    }
    # Handle the case where $Directories is an array
    else
    {
      for ($i = 0; $i -lt $Directories.Count; $i++)
      {
        Write-Host "$($i+1): $($Directories[$i])"
      }
      $Choice = Read-Host "Enter number to change to"
      if ($Choice -match "^\d+$" -and $Choice -ge 1 -and $Choice -le $Directories.Count)
      {
        Change-GgdDir -Dir $Directories[$Choice-1]
      }
    }
  } else
  {
    Write-Host "No directories in ggd."
  }
}
