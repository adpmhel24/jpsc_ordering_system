FROM python:3.9.7
# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends git && apt-get install -y --no-install-recommends vim
COPY requirements.txt ./
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install  --no-cache-dir gunicorn
COPY . .
EXPOSE 8000

CMD ["gunicorn -w 4 -k uvicorn.workers.UvicornWorker", "my_app.main:app", "-b", ":8001"]
# CMD ["uvicorn", "app/my_app/main:app --host 0.0.0.0 --port 8001 --reload"]