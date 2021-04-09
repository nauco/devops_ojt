FROM python:3-alpine

WORKDIR /app

COPY sample-app/requirements.txt .
RUN apk add --update python-pip

RUN pip install -r requirements.txt

COPY sample-app .

EXPOSE 5000

CMD ["python", "./app.py"]
