# Linux Administration Course Project
## Author: [Mohamed Newir](https://www.linkedin.com/in/mohamed-newir-a8a572182)

## Overview
This project is part of a **Linux Administration** course at **Edges Academy** and is divided into **three parts**, each one focusing on different aspects of system administration, scripting, and application development. The project involves Bash scripting, C programming, process management , advanced build systems  and networking. Below is a summary of each part:

## Part 1: Bash Scripting for User and File Management
This part includes two Bash scripts:

### 1. `userdef.sh` (User Management Script)
- Creates a user with a specific **username, password, and group**.
- Assigns a **specific UID and GID**.
- Includes an option to **remove** the user and group.
- Ensures the script runs with **root privileges**.
- Validates the number of arguments passed.

### 2. `dir_files_manager.sh` (File Management Script)
- **Creates a directory** and generates files inside it.
- **Compresses files** into a `.tar` archive.
- Checks if the directory and tar file exist and **deletes them if necessary**.
- If a **specific user exists**, the script copies the archive to the user's home directory and **extracts it**.

## Part 2: Application Development with Makefiles and CMake
This part focuses on **building an application** using Makefiles and CMake. It includes:

- A **main application** that performs **encryption and decryption**.
- Two cryptographic modules:
  - **Caesar Cipher** (Static Library)
  - **XOR Cipher** (Dynamic Library)
- The project's output, including object files, libraries, and the final executable, is organized under `Application/out`.

## Part 3: Process Management with `fork()` and `execv()`
The final part involves **process management** using C:

- Uses **fork()** and **execv()** to execute **system monitoring commands**:
  - `ps` (Process Status)
  - `mpstat` (CPU Usage Statistics)
- The project is **transferred to a Raspberry Pi 5** using `scp`.
- It is then compiled and executed on the Raspberry Pi via `ssh`.

## Project Structure
```
Linux_Admin_Course_Project/
│-- Part1/  (Bash Scripting)
│-- Part2/  (Application Development)
│-- Part3/  (Process Management)
│-- README.md  (Project Documentation)
```