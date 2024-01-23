FROM pytorch/pytorch:1.7.1-cuda11.0-cudnn8-runtime
#
WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get -y install libgl1-mesa-glx libzbar-dev;
RUN apt-get -y install ocl-icd-opencl-dev libgtk2.0-0;
RUN apt-get -y install gnupg2 pass;
COPY ./requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt
RUN pip install torch --extra-index-url https://download.pytorch.org/whl/cu110
#

COPY . .
#
CMD ["python", "main.py", "--character", "real", "--input", "cam", "--debug", "--extend_movement", "1", "--simplify", "0", "--cache", "8gb", "--gpu_cache", "4gb", "--model", "standard_float", "--output_size", "512x512"]
