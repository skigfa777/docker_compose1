FROM python:3.9.5-alpine

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Устанавливаем обновления и необходимые модули
RUN apk update && apk add libpq
RUN apk add --virtual .build-deps gcc python3-dev musl-dev postgresql-dev

# Обновление pip python
RUN pip install --upgrade pip
RUN pip install "psycopg[binary,pool]"

# Установка пакетов для проекта
COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

WORKDIR /app

# Удаляем зависимости билда
RUN apk del .build-deps

# Копирование проекта
COPY . .

# Настройка записи и доступа
RUN chmod -R 777 ./
