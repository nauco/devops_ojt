FROM python:3-alpine

WORKDIR /app
COPY sample-app/requirements.txt .

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
RUN apk update
RUN apk add --update --no-cache python3 py3-pip

RUN pip install -r requirements.txt

COPY sample-app .

EXPOSE 8000

CMD ["python", "./app.py"]
