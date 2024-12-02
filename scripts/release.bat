@echo off
setlocal

REM Check if version is provided
if "%1"=="" (
    echo Please provide a version number (e.g., release.bat 1.0.0)
    exit /b 1
)

set VERSION=%1

REM Ensure we're on main branch
for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
if not "%CURRENT_BRANCH%"=="main" (
    echo Please switch to main branch first
    exit /b 1
)

REM Ensure the working directory is clean
git diff --quiet --exit-code
if errorlevel 1 (
    echo Working directory is not clean. Please commit or stash changes first.
    exit /b 1
)

REM Pull latest changes
echo Pulling latest changes...
git pull origin main

REM Prepare release
echo Preparing release...
call melos run release:prepare

REM Update version
echo Updating version to %VERSION%...
call melos run version %VERSION%

REM Commit version bump
git add .
git commit -m "chore: bump version to %VERSION%"

REM Create and push tag
echo Creating tag v%VERSION%...
git tag -a "v%VERSION%" -m "Release version %VERSION%"

REM Push changes and tag
echo Pushing changes and tag...
git push origin main
git push origin "v%VERSION%"

echo Release %VERSION% prepared and pushed!
echo GitHub Actions will now:
echo 1. Build Android and Windows apps
echo 2. Create a draft release with the builds
echo 3. Generate release notes
echo.
echo Please review and publish the draft release on GitHub when ready.

endlocal
