@echo off

set DOCKER_IMAGE_NAME=license_dev_ait_template_for_aithub

cd /d %~dp0

rem 既存削除
echo start docker crean up...
docker rmi %DOCKER_IMAGE_NAME%
docker system prune -f

rem ビルド
echo start docker build...
docker build -t %DOCKER_IMAGE_NAME% -f ..\deploy\container\dockerfile_license ..\deploy\container

rem 実行
echo run docker...
docker run %DOCKER_IMAGE_NAME%:latest > ../ThirdPartyNotices.txt

pause