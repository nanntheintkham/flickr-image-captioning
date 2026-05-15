@echo off
setlocal EnableDelayedExpansion

REM ============================================================
REM  Push flickr-image-captioning to GitHub
REM  Double-click this file from inside the repo folder.
REM ============================================================

cd /d "%~dp0"

echo.
echo === Flickr Image Captioning - GitHub Push ===
echo.

REM Verify git is installed
where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: git is not installed or not in PATH.
    echo Install Git for Windows from https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Step 1 - prompt for GitHub username
set /p GH_USER="Enter your GitHub username: "
if "%GH_USER%"=="" (
    echo No username entered. Aborting.
    pause
    exit /b 1
)

REM Step 2 - clean the broken .git directory left by the sandbox
if exist .git (
    echo Removing stale .git directory...
    rmdir /s /q .git
)

REM Step 3 - fresh git repo
echo Initializing git repo...
git init -b main
git config user.email "nannkham112@gmail.com"
git config user.name "Nann"

REM Step 4 - stage and commit
echo Staging files...
git add .
echo Committing...
git commit -m "Initial commit: AS1 Image Captioning notebook + dataset scaffold"
if errorlevel 1 (
    echo Commit failed - check git output above.
    pause
    exit /b 1
)

REM Step 5 - add remote
echo Adding remote https://github.com/%GH_USER%/flickr-image-captioning.git
git remote add origin "https://github.com/%GH_USER%/flickr-image-captioning.git"

REM Step 6 - push
echo.
echo Pushing to GitHub. You may be prompted to sign in via browser.
echo.
git push -u origin main
if errorlevel 1 (
    echo.
    echo Push failed. Most common causes:
    echo   1. You haven't created the empty repo at https://github.com/new yet.
    echo      Use the EXACT name: flickr-image-captioning
    echo      Do NOT initialize it with README, .gitignore, or license.
    echo   2. Your local Git has no GitHub credentials. Run:
    echo        git config --global credential.helper manager
    echo      Then re-run this script.
    pause
    exit /b 1
)

echo.
echo === DONE ===
echo Your repo is live at: https://github.com/%GH_USER%/flickr-image-captioning
echo.
pause
