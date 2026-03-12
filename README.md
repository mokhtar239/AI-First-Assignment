# Setup Instructions - Prolog Project

## 1. Install SWI-Prolog

Open terminal and run:

```
winget install SWI-Prolog.SWI-Prolog
```

## 2. Add to PATH (if `swipl` not recognized)

1. Press `Win + R`, type `sysdm.cpl`, press Enter
2. Go to **Advanced** tab → **Environment Variables**
3. Under **System variables**, find **Path**, click **Edit**
4. Click **New** and add:
   ```
   C:\Program Files\swipl\bin
   ```
5. Click **OK** on all dialogs
6. **Restart VS Code / terminal**

## 3. Verify Installation

```
swipl --version
```

Should output: `SWI-Prolog version 10.0.1`

## 4. (Optional) VS Code Extension

- Go to Extensions (`Ctrl+Shift+X`)
- Search **"VSC-Prolog"** and install it

## 5. Fix Linter Error

If you see: `Cannot lint the prolog file. The Prolog executable was not found.`

1. Press `Ctrl+Shift+P` → type **"Preferences: Open Settings (JSON)"**
2. Add this line inside the `{}` brackets:
   ```json
   "prolog.executablePath": "C:\\Program Files\\swipl\\bin\\swipl.exe"
   ```
3. Save and reload VS Code (`Ctrl+Shift+P` → **"Reload Window"**)

## 6. Run the Solution

> **Important:** Use **Command Prompt (cmd)**, not PowerShell

```
cd src
swipl -s solution.pl
```

Then type queries:

```prolog
?- most_borrowed_book(B).
?- borrowers_count(recursion_in_depth, N).
```

Type `halt.` to exit.

## 7. Run Tests

```
cd tests
swipl -s test_solution.pl -g run_tests -t halt
```
