#!/bin/bash

# Активируем виртуальное окружение (если используется)
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Установка/обновление необходимых пакетов
pip install --upgrade setuptools wheel twine

# Очистка предыдущих сборок
rm -rf build dist *.egg-info

# Сборка пакета
python setup.py sdist bdist_wheel

# Проверка пакета
python -m twine check dist/*

# Запрос на публикацию
read -p "Хотите опубликовать пакет на PyPI? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Выбор репозитория
    read -p "Выберите репозиторий (1 - TestPyPI, 2 - PyPI): " repo
    case $repo in
        1)
            echo "Загрузка на TestPyPI..."
            python -m twine upload --repository testpypi dist/*
            ;;
        2)
            echo "Загрузка на PyPI..."
            python -m twine upload dist/*
            ;;
        *)
            echo "Неверный выбор. Отмена публикации."
            ;;
    esac
fi

# Деактивация виртуального окружения (если было активировано)
if [ -d "venv" ]; then
    deactivate
fi