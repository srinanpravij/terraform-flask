FROM python:3.7-alpine
RUN mkdir /tfflaskapp
WORKDIR /tfflaskapp
COPY ./tfflask /tfflaskapp
RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["python","web.py"]
