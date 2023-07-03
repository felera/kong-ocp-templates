FROM pantsel/konga:latest

ARG STORAGE_PATH=/app/konga/data

# Set the working directory
WORKDIR ${STORAGE_PATH}

USER root

COPY start.sh ${STORAGE_PATH}/start.sh

# Set the group ownership recursively and change the file permissions
RUN chgrp -R 0 ${STORAGE_PATH} && \
    chmod -R g=u ${STORAGE_PATH} && \
    chown -R 1001 ${STORAGE_PATH}

# Change the user to 1001
USER 1001

# Start the Konga application
CMD ["./start.sh"]
