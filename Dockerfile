FROM ghcr.io/osgeo/gdal:ubuntu-full-3.8.3



RUN apt-get -y update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing \
  --no-install-recommends \
  build-essential \
  gettext \
  python3-pip \
  python3-dev \
  python3-setuptools \
  python3-wheel \
  python3-cffi \
  shared-mime-info \
  tzdata \
  && ln -fs /usr/share/zoneinfo/Europe/Zurich /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata
# Copy files in another location to solved windows rights issues
# These files are only used during build process and by entrypoint.sh for dev

ARG ENV
WORKDIR /code
COPY requirements_dev.txt requirements_dev.txt
COPY requirements.txt requirements.txt

RUN if [ "$ENV" = "DEV" ] ; \
    then \
    echo "Installing development dependencies..." \
    && pip3 install -r requirements_dev.txt \
    && echo "########################################" \
    && echo "# Installed development dependencies   #" \
    && echo "########################################"; \
    else \
    pip3 install -r requirements.txt \
    && echo "########################################" \
    && echo "# Installed production dependencies    #" \
    && echo "########################################"; \
    fi

COPY . /code/
