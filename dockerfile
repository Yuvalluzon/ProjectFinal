FROM python:3.8-slim  

COPY ./templates /app/templates

COPY requirements.txt /app

COPY app.py /app

COPY init-db.js /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT python3 app.py






