# ggd (Go Go Directory) - PowerShell

A PowerShell script for quickly navigating to frequently used directories.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-blue)](https://learn.microsoft.com/en-us/powershell/)

## Overview

`ggd` (Go Go Directory) is a simple yet powerful PowerShell script that helps you quickly access your favorite directories. It stores a list of frequently used directories in a text file and provides commands to add, remove, navigate to, list, and clear these directories, using `fzf` for fuzzy searching and easy selection.

## Features

*   **Add Directories:** Quickly add the current directory to the list.
*   **Remove Directories:** Interactively select and remove directories from the list using `fzf`.
*   **Navigate to Directories:** Interactively select and navigate to a directory from the list using `fzf`.
*   **List Directories:** Display the list of stored directories.
*   **Clear Directories:** Clear all stored directories from the list.
*   **Fuzzy Searching:** Uses `fzf` for fast and intuitive directory selection.
*   **Cross-Session Persistence:** Directories are stored in a file, so they persist across PowerShell sessions.

## Prerequisites

*   **PowerShell 5.1 or later:**  `ggd` is written in PowerShell and requires PowerShell 5.1 or later to function correctly.
*   **`fzf` (Fuzzy Finder):** `ggd` relies on `fzf` for interactive directory selection.  You must have `fzf` installed and in your system's `PATH`.

    *   **Windows:**
        *   **Winget:** `winget install fzf`
        *   **Chocolatey:** `choco install fzf`
        *   **Manual:** Download the `fzf.exe` executable from the `fzf` GitHub releases page ([https://github.com/junegunn/fzf/releases](https://github.com/junegunn/fzf/releases)) and place it in a directory that's in your `PATH`.
    *   **macOS:** `brew install fzf`
    *   **Linux:** Use your distribution's package manager (e.g., `apt install fzf`, `yum install fzf`).

## Installation

1.  **Download `ggd.ps1`:** Download the `ggd.ps1` script to a directory on your computer (e.g., `C:\Scripts`).
2.  **Add the Directory to Your `PATH`:** Add the directory containing `ggd.ps1` to your system's `PATH` environment variable. This allows you to run the `ggd` command from any directory.

    *   **Windows (Graphical Method):**
        1.  Search for "environment variables" in the Start menu and select "Edit the system environment variables."
        2.  Click "Environment Variables..."
        3.  In the "System variables" section, find the `Path` variable and select it.
        4.  Click "Edit..."
        5.  Click "New" and add the full path to the directory where you saved `ggd.ps1` (e.g., `C:\Scripts`).
        6.  Click "OK" on all the dialog boxes to save the changes.
    *   **Windows (PowerShell Method - Current Session Only):**

        ```powershell
        $env:Path += ";C:\Scripts"  # Replace C:\Scripts with the actual path
        ```

        (For a permanent change, modify the system or user environment variables.)

3.  **Restart PowerShell:** Close and reopen PowerShell for the `PATH` changes to take effect.

## Usage

```powershell
ggd <command>
```

*   **`ggd a`:**  Adds the current directory to the list of frequently used directories.

    ```powershell
    ggd a
    ```

*   **`ggd r`:**  Removes a directory from the list.  `fzf` will be used to select the directory to remove.

    ```powershell
    ggd r
    ```

*   **`ggd` (no arguments):** Navigates to a directory from the list. `fzf` will be used to select the directory to navigate to.

    ```powershell
    ggd
    ```

*   **`ggd list`:** Lists all the stored directories.

    ```powershell
    ggd list
    ```

*   **`ggd clear`:** Clears all stored directories from the list.

    ```powershell
    ggd clear
    ```

## Configuration

*   **`$Filename`:**  The path to the file where `ggd` stores the list of directories. The default is `$HOME\.ggd_dirs.txt`.  You can modify this variable at the top of the `ggd.ps1` script to change the filename or location.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or create issues for bug reports or feature requests.

## Author

groovyghoul (Richard O'Neil)

## Acknowledgments

*   [junegunn/fzf](https://github.com/junegunn/fzf): For the awesome fuzzy finder.
*   [PowerShell Community](https://powershell.org):  For the great resources and support.

## TODO

[ ] add ability to alias folders?
