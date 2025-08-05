# Base image
# Start with a lightweight Linux system that already has Python 3.9 installed
# python:3.9-slim means it uses Python 3.9 with a slimmed-down version of Debian (fewer tools, smaller size, faster download).
FROM python:3.9-slim

#This sets /app as the working directory inside the container.
# All future commands (like COPY, RUN, CMD) will happen inside this folder.
# If /app doesn’t exist, Docker creates it.
# Set working directory
WORKDIR /app

# Copy files
# Copies everything from your current project folder on your local machine into the container’s /app folder.
# COPY <source> <destination>
COPY . .

# Install dependencies
# Installs all Python packages listed in requirements.txt.
# This is done inside the container using pip.
RUN pip install -r requirements.txt

# Expose port
# This tells Docker that the container uses port 5000 (Flask default).
# This does not open the port, it’s just for documentation and mapping.
EXPOSE 8080
# "Whatever is running inside the container on port 5000, I want to be able to access it from my local machine on port 8080."

# Run the app
# This sets the default command that runs when the container starts.
# It runs: python app.py inside /app.
# Tip: CMD should always be in JSON format (array form with double quotes) to avoid shell issues.
CMD ["python", "app.py"]

# summary
# This Dockerfile does the following:
# Starts from a minimal Python base.
# Sets /app as the workspace.
# Copies your code into it.
# Installs dependencies.
# Tells Docker to expect traffic on port 5000.
# Runs your Python app (app.py).

# When is the container created?
# Containers are not created during docker build.
# docker build creates an image — a blueprint for containers.
# Containers are only created and run when you use docker run.

# Here's what happens step by step:

# Step	What Happens	Where
# FROM python:3.9-slim	Start from a base image (like an empty OS + Python)	Creates a temporary environment (called a build layer)
# WORKDIR /app	Set working directory inside the image	Prepares where next commands will run
# COPY . .	Copy all files from your local folder (where Dockerfile is) to /app in the image	Still just building the image
# RUN pip install -r requirements.txt	Installs dependencies inside the image	Adds layers to the image
# EXPOSE 5000	Documents that the app will use port 5000	For reference only
# CMD ["python", "app.py"]	Defines the default command to run when container starts
# docker build = builds image (blueprint) using the Dockerfile (copies, installs, prepares)
# COPY . . during build = copies local files into the image layers
# docker run = creates and runs a container from that image