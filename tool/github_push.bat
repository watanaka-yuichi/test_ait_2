@echo off

echo #####AIT GITHUB PUSH#####

set INPUT_INVENTORY_ADD_FLAG=
set INPUT_COMMIT_COMMENT=
set COMMIT_ID=
set REPO_URL=

choice /c YN /m "--- Step-1 Inventory upload? (Y:upload AN:not upload) : " /n
if errorlevel 1 set INPUT_INVENTORY_ADD_FLAG=Y
if errorlevel 2 set INPUT_INVENTORY_ADD_FLAG=N

echo Selected Inventory upload : %INPUT_INVENTORY_ADD_FLAG%

echo --- Step-2 Input commit comment.
set /P INPUT_COMMIT_COMMENT=


echo Inputed commit comment : %INPUT_COMMIT_COMMENT%

cd ..

git add deploy
git add develop
git add tool
git add LICENSE.txt readme.md ThirdPartyNotices.txt

if %INPUT_INVENTORY_ADD_FLAG%==Y (
 git add local_qai/inventory
)

git commit -m %INPUT_COMMIT_COMMENT%

git push origin main

if %errorlevel% neq 0 (
  echo Failed push to Github.
)

git show --format="%%H" --no-patch > commit_id.txt
for /f "tokens=1" %%a in (commit_id.txt) do (
  set COMMIT_ID=%%a
)
del commit_id.txt


git remote get-url origin > repo_url.txt
for /f "tokens=1" %%b in (repo_url.txt) do (
  set REPO_URL=%%b
)
del repo_url.txt

echo ----------- Repository URL Start----------
echo %REPO_URL:~0,-4%/tree/%COMMIT_ID%
echo ----------- Repository URL End-----------
PAUSE
EXIT