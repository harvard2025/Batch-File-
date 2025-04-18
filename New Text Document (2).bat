@echo off
title Auto GitHub Uploader
color 0A

:: ============================================
:: CONFIGURE THESE VARIABLES FOR YOUR PROJECT
:: ============================================
set GITHUB_REPO_URL=https://github.com/harvard2025/Batch-File-.git
set COMMIT_MESSAGE=Auto commit by batch script
set BRANCH_NAME=main
:: ============================================

echo.
echo Starting automatic GitHub upload process...
echo.

:: Fix Git safety issue
echo Fixing repository ownership issues...
git config --global --add safe.directory "D:/proggraming/Web Development/batch"

:: Step 1: Initialize Git if not already initialized
if not exist ".git" (
    echo Initializing Git repository...
    git init
    if errorlevel 1 (
        echo Error initializing Git repository
        pause
        exit /b 1
    )
)

:: Step 2: Add all files to staging
echo Adding all files to staging...
git add --all
if errorlevel 1 (
    echo Error adding files to staging
    pause
    exit /b 1
)

:: Step 3: Commit changes
echo Committing changes with message: "%COMMIT_MESSAGE%"
git commit --all --message "%COMMIT_MESSAGE%"
if errorlevel 1 (
    echo Error committing changes (maybe no changes to commit?)
)

:: Step 4: Add remote origin if not already added
git remote | find "origin" >nul
if errorlevel 1 (
    echo Adding remote origin...
    git remote add origin "%GITHUB_REPO_URL%"
    if errorlevel 1 (
        echo Error adding remote origin
        pause
        exit /b 1
    )
)

:: Step 5: Push to GitHub
echo Pushing to %BRANCH_NAME% branch...
git push --set-upstream origin %BRANCH_NAME%
if errorlevel 1 (
    echo Error pushing to GitHub
    pause
    exit /b 1
)

echo.
echo All steps completed successfully!
echo Repository: %GITHUB_REPO_URL%
echo Branch: %BRANCH_NAME%
echo Commit: "%COMMIT_MESSAGE%"
echo.
pause