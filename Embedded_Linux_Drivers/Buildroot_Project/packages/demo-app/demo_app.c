/*
Author: Mohamed Newir
Date: 15/02/2025
File: demo_app.c
Description:    
            This is a simple demo application that interacts with a switch and an LED device.
            It allows the user to turn the LED on or off by setting the switch state.
            The application opens the device files for the switch and LED, and then enters a loop
            where it prompts the user to enter the switch state (0 or 1). Based on the input,
            it writes the state to both the switch and LED device files. The loop continues until
            the user chooses to exit the application.
*/

/*
    Used libraries:
    - stdio.h: For standard input and output functions.
    - fcntl.h: For file control options, specifically for opening files.
    - unistd.h: For POSIX operating system API, specifically for close function.
*/
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

/*
    Function: main
    Description: The main function of the demo application.
    It opens the LED and switch device files, enters a loop to read user input,
    writes the input to the device files, and allows the user to exit the application.
*/
int main() {
    int led_fd = open("/dev/led", O_RDWR);
    int switch_fd = open("/dev/switch", O_RDWR);
    if (led_fd < 0 || switch_fd < 0) {
        printf("Failed to open devices\n");
        return 1;
    }
    printf("Set switch to 1 to turn on LED, 0 to turn off.\n");
    char switch_state;
    char exit_flag;
    /*
        The loop continues until the user chooses to exit.
        It prompts the user to enter the switch state (0 or 1),
        validates the input, and writes the state to both device files.
        The user can exit the loop by entering 'y' or 'Y'.
        The loop will continue until the user chooses to exit.
    */
    while (1) {
        printf("\nEnter switch state (0/1): ");
        scanf(" %c", &switch_state);
        // Validate input to ensure it's either '0' or '1'
        if (switch_state != '0' && switch_state != '1') {
            printf("Invalid input. Please enter 0 or 1.\n");
            continue;
        }
        // Write the switch state to the switch device and LED device
        write(switch_fd, &switch_state, 1);
        write(led_fd, &switch_state, 1);
        printf("Switch: %c, LED set to %c\n", switch_state, switch_state);

        // Exiting the loop if the user wants to
        printf("Do you want to exit (y/n): ");
        scanf(" %c", &exit_flag);
        if(exit_flag == 'y' || exit_flag == 'Y') {
            printf("Exiting Demo App ...\n");
            break;
        }

    }
    close(led_fd);
    close(switch_fd);
    return 0;
}
