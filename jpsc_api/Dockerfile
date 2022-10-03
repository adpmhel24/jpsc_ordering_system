FROM python:3.9.7
# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends git && apt-get install -y --no-install-recommends vim

COPY requirements.txt ./
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000

CMD ["uvicorn", "my_app.main:app", "--host", "0.0.0.0", "--port", "8001", "--reload"]
# CMD ["uvicorn", "app/my_app/main:app --host 0.0.0.0 --port 8001 --reload"]