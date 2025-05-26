#!/usr/bin/env bash
# Название: Lab#1 - DevOps_Course_2025
# Описание: Скрипт для запроса погоды и вывода в html файл
# Автор: Нестеров Алексей
# Пример использования: ./script.sh [CITYNAME]

# Переменные
CITYNAME=$1

# Функция для получения информации о погоде
function getWeatherInfo () {
    curl --silent "http://wttr.in/${1}?format=j1" | jq '.current_condition[0] | { "Local observation time": .localObsDateTime, "Temperature": .temp_C, "Humidity": .humidity }'
}

# Проверка наличия необходимых пакетов
dependencies=("curl" "jq")

for dependency in "${dependencies[@]}"; do
    if ! command -v "$dependency" &> /dev/null; then
        echo "Error: $dependency is not installed."
        exit 1
    fi
done

# Обработка ввода
if [[ $# -eq 1 ]] ; then
    weather=$(getWeatherInfo "$CITYNAME")

    html="<!DOCTYPE html>
    <html>
    <head>
    <title>Lab#1 - DevOps_Course_2025</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif; }
    </style>
    </head>
    <body>
    <h1>Lab#1 - DevOps_Course_2025</h1>
    <p>${weather}</p>
    </body>
    </html>"

    echo "${html}" 
else
    echo "Usage: $0 [CITYNAME]"
fi
