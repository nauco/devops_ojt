FROM python:3

WORKDIR /app

COPY sample-app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY sample-app .

EXPOSE 5000

CMD ["python", "./app.py"]
