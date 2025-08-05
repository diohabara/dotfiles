FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a test user with sudo privileges
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the test user
USER testuser
WORKDIR /home/testuser

# Copy the dotfiles
COPY --chown=testuser:testuser . /home/testuser/.dotfiles/

# Test the setup script
CMD ["/bin/bash"]