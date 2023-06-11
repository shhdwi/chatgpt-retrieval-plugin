#
#FROM python:3.10 as requirements-stage
#
#WORKDIR /tmp
#
#RUN pip install poetry
#
#COPY ./pyproject.toml ./poetry.lock* /tmp/
#
#
#RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM python:3.10

WORKDIR /code

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . /code/

# Heroku uses PORT, Azure App Services uses WEBSITES_PORT, Fly.io uses 8080 by default
CMD ["sh", "-c", "uvicorn server.main:app --host 0.0.0.0 --port ${PORT:-${WEBSITES_PORT:-8080}}"]
#CMD ["python","server/main.py"]