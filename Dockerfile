FROM python:3-alpine

WORKDIR /app

COPY sample-app/requirements.txt .
RUN pip install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org Flask

COPY sample-app .

EXPOSE 5000

CMD ["python", "./app.py"]
