# Klayout Docker Image Builder

Scripts to build a Docker image for Klayout and copy binaries from the container to the host.

## Prerequisites

- Docker
- Bash

## Scripts
1. `build_binaries.sh`
2. `copy_binaries_to_host.sh`

### Building the Docker Image

1. **Run the `build_binaries.sh` script:**
   - This script will prompt you to enter the version of Klayout you wish to build.
   - Enter the desired version in the terminal when prompted.
   - The script will then build the specified version of Klayout in a Fedora-based Docker container.

2. **Copy binaries to the host:**
   - Once the software is successfully built inside the container, run the `copy_binaries_to_host.sh` script.
   - This script will copy the built binaries from the container to the host machine.
   - The files will be copied to the `/opt/klayout-$version` directory on your host.

3. **Running Klayout:**
   - You can run Klayout by executing the following command:
     ```bash
     /opt/klayout-$version/klayout
     ```

### Notes

- Ensure Docker is running on your machine before executing the scripts.
- You might need to run these scripts with elevated privileges (e.g., using `sudo`) depending on your system configuration.
- By following these steps, you will have Klayout installed and ready to use on your host machine.
- You can customize the Dockerfile for building on different Linux distributions.
- To add Klayout to your PATH, you can create a symbolic link:
  ```bash
  ln -s /opt/klayout-$version .local/bin/klayout
