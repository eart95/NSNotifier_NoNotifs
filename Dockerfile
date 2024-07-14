# Use the official Swift image
FROM swift:5.7

# Create a directory for the app
WORKDIR /app

# Copy the Swift package files to the container
COPY . .

# Build the Swift package
RUN swift build -c release

# Set the entry point for the container
CMD ["./.build/release/NightscoutNotifier"]
