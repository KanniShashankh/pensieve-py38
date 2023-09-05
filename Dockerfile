# Use an official Python 3.8 image as the base image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# RUN pip install --trusted-host pypi.python.org -r requirements.txt
RUN pip install numpy tensorflow==2.7 tflearn matplotlib selenium
# Run setup.py in the root directory

RUN python setup.py install

RUN pip uninstall -y protobuf

# Install protobuf version 3.20.0
RUN pip install protobuf==3.20.0

# Create a shell script to run all the Python scripts
RUN echo '#!/bin/sh\n\
python test/get_video_sizes.py\n\
python test/rl_no_training.py\n\
python real_exp/run_exp.py\n' > run_scripts.sh && chmod +x run_scripts.sh




# Run the shell script as the entry point
CMD ["./run_scripts.sh"]
