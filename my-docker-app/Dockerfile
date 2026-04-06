FROM python:3.11-slim

WORKDIR /app

COPY app.py .

EXPOSE 8080

CMD ["python", "app.py"]

#FROM python:3.11-slim — start from an official Python image. slim means minimal size
#WORKDIR /app — all commands from here run inside /app folder in the container
#COPY app.py . — copy your app.py from your machine into /app in the container
#EXPOSE 8080 — tell Docker this container listens on port 8080
#CMD ["python", "app.py"] — when the container starts, run this command


#What is a Dockerfile?
#It's a recipe that tells Docker HOW TO BUILD  your image. Every line is an INSTRUCTION.

#The most common instructions:
#FROM        — start from an existing base image
#RUN         — run a command while building
#COPY        — copy files from your machine into the image
#WORKDIR     — set the working directory inside the container
#CMD         — the command to run when the container starts
