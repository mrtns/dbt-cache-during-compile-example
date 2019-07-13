# Based on https://github.com/davidgasquez/dbt-docker
#   but with configurable dbt version
FROM python

ARG dbt_git_url

ENV USER_NAME dbt
ENV DBT_DIR /dbt
ENV DBT_CONFIG_DIR /home/dbt/.dbt
ENV DBT_GIT_URL $dbt_git_url

# Create dbt user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u 1000 $USER_NAME && \
    mkdir -p $DBT_DIR && \
    mkdir -p $DBT_CONFIG_DIR && \
    chown --recursive $USER_NAME $DBT_DIR && \
    chown --recursive $USER_NAME $DBT_CONFIG_DIR

# Update and install system packages
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q \
        git libpq-dev python-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install DBT
RUN pip install -e $DBT_GIT_URL

# Switch to the proper user
USER $USER_NAME

# Set working directory
WORKDIR $DBT_DIR

# Run dbt
ENTRYPOINT ["dbt"]
