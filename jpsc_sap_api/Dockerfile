FROM python:3.9.7
# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends git && apt-get install -y --no-install-recommends vim && apt-get install -y --no-install-recommends curl


RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

RUN echo 'export PATH="$PATH:/opt/mssql-tools17/bin"' >> ~/.bashrc
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN apt-get install -y unixodbc unixodbc-dev

COPY requirements.txt ./
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8002

CMD ["uvicorn", "my_app.main:app", "--host", "0.0.0.0", "--port", "8002", "--reload"]