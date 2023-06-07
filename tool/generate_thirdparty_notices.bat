@echo off

set DOCKER_IMAGE_NAME=license_dev_ait_template_for_aithub

cd /d %~dp0

rem Šù‘¶íœ
echo start docker crean up...
docker rmi %DOCKER_IMAGE_NAME%
docker system prune -f

rem ƒrƒ‹ƒh
echo start docker build...
docker build -t %DOCKER_IMAGE_NAME% -f ..\deploy\container\dockerfile_license ..\deploy\container

rem ŽÀs
echo run docker...
docker run %DOCKER_IMAGE_NAME%:latest > ../ThirdPartyNotices.txt

pause