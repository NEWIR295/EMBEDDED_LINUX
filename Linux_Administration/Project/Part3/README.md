# Linux Administration Project - Part 3
## Author: [Mohamed Newir](https://www.linkedin.com/in/mohamed-newir-a8a572182)

## Project Part 3 Overview
This project is the third part of a **Linux Administration** course project. It involves process management using **fork** and **execv** to execute system monitoring commands (`ps` and `mpstat`). The project is compiled and executed on a host machine before being transferred using `scp` command to a **Raspberry Pi 5** for execution using `ssh` command.

## Project Structure
```
Linux_Administration/Project/Part3/
│-- Build/
│   │-- Output (Executable File)
│-- Source/
│   │-- main.c  (Source Code)
│-- README.md
│-- CMakeLists.txt
```

## Features
- Uses **fork()** and **execv()** system calls to execute:
  - `ps` command (process status)
  - `mpstat` command (CPU usage statistics)
- Compilation on a **host machine**.
- Transfer of the compiled project to **Raspberry Pi 5**.
- Execution on **Raspberry Pi 5** using SSH.


## Compilation and Execution
### Step 1: Compile the Project on the Host Machine
```sh
cd Linux_Administration/Project/Part3/Build
cmake ..
make
```
This generates the executable inside the `Build/Output` directory.

### Step 2: Transfer to Raspberry Pi 5
Use `scp` to transfer the compiled output:
```sh
scp -P 22 -r Project <Raspberry_User_Name>@<RaspberryPi_IP>:/home/<pi_user>/
```
Replace `<RaspberryPi_IP>` with the actual IP address of your Raspberry Pi 5 and `<Raspberry_User_Name>` with the actual raspberry pi user name.

### Step 3: SSH into Raspberry Pi 5
Log in remotely using SSH:
```sh
ssh -p 22 <Raspberry_User_Name>@<RaspberryPi_IP>
```

### Step 4: Navigate and Execute the Program
```sh
cd /home/pi/Project/Part3/Build/
./Output
```
This will execute the `ps` and `mpstat` commands using **fork** and **execv** ant it will show both process status and CPU usage statistics.

![ Testing Part 3 in Linux Administration Project ](Video/Project_Part3.mp4)
---

