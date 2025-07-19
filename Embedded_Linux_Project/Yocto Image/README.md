# Yocto Image

## Author: [Mohamed Newir](https://www.linkedin.com/in/mohamed-newir-a8a572182)

## Overview

This project provides a Yocto-based image for running a Client application on QEMU, designed to communicate with a Qt6-based Server GUI running on a host machine. The Client application, implemented in C++, uses TCP socket communication to receive temperature threshold updates from the Server GUI and send temperature readings in response. The Yocto image is built using a custom layer (`meta-client-layer`) that includes the Client application, enabling it to run on a QEMU-emulated device. The project demonstrates the integration of Yocto for embedded Linux image creation with socket programming for IoT communication.

## Objective

The objective of this project is to create a lightweight Yocto image that runs a TCP Client application on QEMU, capable of interacting with a Server GUI on the host machine. Key features include:

- Deployment of a Client application on an embedded Linux system (QEMU) that communicates with a host-based Server GUI over TCP.
- Use of a custom Yocto layer (`meta-client-layer`) to package the Client application, including its socket communication logic.
- Demonstration of cross-platform IoT communication, where the Client handles temperature data exchange and LED status updates.

## Project Structure

The project is organized into the following directories and files:

```
/Yocto Image
├── meta-client-layer
│   ├── conf
│   │   └── layer.conf                  # Configuration for the custom Yocto layer
│   ├── README                          # Layer-specific documentation
│   ├── recipes-apps
│   │   └── client
│   │       ├── client_1.0.bb           # BitBake recipe for the Client application
│   │       └── files
│   │           ├── CMakeLists.txt      # CMake configuration for building the Client
│   │           ├── Include
│   │           │   ├── channel.hpp     # Abstract base class for communication channels
│   │           │   ├── clientChannel.hpp  # Client-specific channel implementation
│   │           │   ├── socket.hpp      # Abstract socket interface
│   │           │   └── TCPsocket.hpp   # TCP socket implementation
│   │           └── Source
│   │               ├── clientChannel.cpp  # ClientChannel class implementation
│   │               ├── client.cpp         # Client application main logic
│                   └── TCPsocket.cpp      # TCPSocket class implementation
├── README.md                               # Project documentation
└── yocto_image_Drive_Link.txt              # Link to the generated Yocto image
```

## Prerequisites

- **Yocto Project**: Poky (Yocto Project reference distribution) with a compatible release (e.g., Kirkstone).
- **Host System**: Linux distribution (e.g., Ubuntu) with necessary tools (`git`, `python3`, `cmake`, etc.).
- **QEMU**: Installed for emulating the Yocto image.
- **Dependencies**: Standard C++ library and POSIX socket libraries (`sys/socket.h`, `arpa/inet.h`, etc.).
- **Server GUI**: The Qt6-based Server GUI application.
- **Tools**: BitBake, and a C++ compiler (e.g., `g++`).

## Building the Yocto Image

### Step 1: Set Up the Yocto Environment

1. Clone the Poky repository:

   ```bash
   git clone -b kirkstone git://git.yoctoproject.org/poky
   cd poky
   ```

2. Source the Yocto environment:

   ```bash
   source oe-init-build-env build
   ```

   This creates a `build` directory and sets up the build environment.

### Step 2: Add the Custom Layer

1. Copy the `meta-client-layer` directory to the Poky root (e.g., `poky/meta-client-layer`).

2. Add the custom layer to the build configuration:

   ```bash
   bitbake-layers add-layer ../meta-client-layer
   ```

3. Verify the layer is added:

   ```bash
   bitbake-layers show-layers
   ```

   Ensure `meta-client-layer` appears in the output.

### Step 3: Configure the Build

1. Edit `conf/local.conf` in the `build` directory to include the Client application:

   ```bash
   nano conf/local.conf
   ```
2. Add the following line to include the Client application in the image:

   ```conf
   IMAGE_INSTALL:append = " client"
   ```
3. Configure the machine for QEMU:

   ```conf
   MACHINE ??= "qemuarm64"
   ```

   Save and exit.

### Step 4: Build the Image

1. Build the `core-image-base` image, which includes the Client application:

   ```bash
   bitbake core-image-base
   ```
2. The build process generates the image in `build/tmp/deploy/images/qemux86-64/`.

### Step 5: Run the Image in QEMU

1. Run the generated image using QEMU:

   ```bash
   runqemu qemuarm64
   ```

   This boots the Yocto image in QEMU with the Client application installed.

## Usage

### Running the Server GUI on the Host

1. Build and run the Qt6-based Server GUI on the host machine (assumed to be built from the `Server_Gui` project):

   ```bash
   cd Server_Gui/build
   ./Server_Gui 192.168.7.2 8080
   ```

   - Use an IP address accessible from QEMU (e.g., `192.168.7.2` for QEMU’s default network).
   - Default port: `8080`.

2. The Server GUI opens with four tabs:

   - **Real Time Monitor**: Displays a QML-based meter for the current temperature.
   - **Historical Analysis**: Shows a QML chart of temperature history.
   - **Configuration**: Allows setting the temperature threshold.
   - **Quick Access**: Provides social media links.

### Running the Client on QEMU

1. Boot the Yocto image in QEMU (as described above).

2. Log in to the QEMU system (default user: `root`, no password).

3. Run the Client application, specifying the host machine’s IP and port:

   ```bash
   client 192.168.7.2 8080
   ```

   - Match the IP and port used by the Server GUI.

4. The Client will:

   - Connect to the Server GUI.
   - Receive and display threshold updates (e.g., `Received new threshold: 30 °C – LED Status: OFF`).
   - Prompt for temperature input when requested (e.g., `Enter temperature: `).
   - Send the entered temperature to the Server GUI.

### Example Interaction

1. Start the Server GUI on the host:

   ```bash
   ./Server_Gui/build/Server_Gui 192.168.7.2 8080
   ```

2. Boot the Yocto image in QEMU and run the Client:

   ```bash
   runqemu qemuarm64
   client 192.168.7.2 8080
   ```

   Client output:

   ```
   Attempting to connect to the server...
   Connected to the server.
   Received new threshold: 30 °C – LED Status: OFF
   ```

3. In the Server GUI’s Configuration tab, set a new threshold (e.g., 35°C):

   - Server sends: `set threshold 35 OFF`.
   - Client receives: `Received new threshold: 35 °C – LED Status: OFF`.

4. The Server GUI sends a `get Temp` request:

   - Client prompts: `Enter temperature: `(e.g., enter `40`).
   - Client sends: `40`.
   - Server GUI updates the Real Time Monitor meter to 40°C, adds the value to the Historical Analysis chart, and sets LED status to "ON" (green).

5. Close the Server GUI to stop the connection, or terminate the QEMU session to stop the Client.

## Notes

- **Networking**: Ensure QEMU’s network is configured to allow communication with the host (e.g., `192.168.7.2` is the default host IP in QEMU’s SLIRP networking). Adjust IP addresses if using a different network setup.
- **Client Application**: The Client is included in the `meta-client-layer` and built using CMake, as specified in `client_1.0.bb`.
- **Server GUI**: the Qt6-based application from the `Server_Gui` project, running on the host machine.
- **Image Location**: The generated Yocto image is referenced in `yocto_image_Drive_Link.txt` for external access.
- **Extensibility**: The `meta-client-layer` includes a `UDPsocket` implementation, but the Client uses TCP for communication with the Server GUI.
- **QEMU Machine**: The instructions use `qemuarm64`, but other QEMU machines can be configured in `local.conf` if needed.
