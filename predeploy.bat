@echo off
:: Скрипт для удаления определённых файлов и папок рекурсивно

echo Удаление файлов и папок в текущей директории и её подпапках...
pause

:: Удаление файлов с расширением .baselua
for /r %%i in (*.baselua) do (
    echo Удаление файла: %%i
    del /f /q "%%i"
)

:: Удаление файлов с расширением .py
for /r %%i in (*.py) do (
    echo Удаление файла: %%i
    del /f /q "%%i"
)

:: Удаление папок с именем .git
for /d /r %%i in (.git) do (
    echo Удаление папки: %%i
    rd /s /q "%%i"
)

:: Удаление файлов LICENSE
for /r %%i in (LICENSE) do (
    echo Удаление файла: %%i
    del /f /q "%%i"
)

:: Удаление файлов .gitignore
for /r %%i in (.gitignore) do (
    echo Удаление файла: %%i
    del /f /q "%%i"
)

:: Удаление файлов README
for /r %%i in (README.md) do (
    echo Удаление файла: %%i
    del /f /q "%%i"
)

echo Операция завершена!
pause