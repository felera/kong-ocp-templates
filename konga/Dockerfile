# Use the latest Konga image as the base image
FROM pantsel/konga:latest

# Set the working directory to the Konga app directory
WORKDIR /app/konga

# Copy the custom config.js file to the app directory
COPY ./config.js .

# Copy the start.sh script to the app directory
COPY ./start.sh .

# Set the execute permissions for the start.sh script and konga folder
RUN chmod +x start.sh && chgrp -R 0 /app/konga && chmod -R g=u /app/konga 


# Set the user to run Konga as a non-root user
USER 1001

# Start Konga using the start.sh script
CMD ["./start.sh"]
