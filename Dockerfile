FROM python:3-alpine

WORKDIR /app

COPY sample-app/requirements.txt .
RUN pip install -r requirements.txt

COPY sample-app .

EXPOSE 8000

CMD ["python", "app.py"]
