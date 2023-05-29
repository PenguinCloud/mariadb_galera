FROM ghcr.io/penguincloud/core:v5.0.1 AS BUILD
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# PUT YER ARGS in here
ARG DB_ROOT_PASSWORD="p@ssword"
ARG DB_HOST="mariadbgalera"
ARG APP_TITLE="Mariadbgalera"
ARG PTG_USER_PASSWOPRD="password123"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DB_ROOT_PASSWORD="p@ssword"
ENV DB_PASSWORD="p@ssword1"
ENV DB_HOST="mariadbgalera"
ENV DB_USER="ptg-user"

# Switch to non-root user
# USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
