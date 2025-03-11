/*
Author: Mohamed Newir
Date: 10/03/2025
File: main.c
Description:
    C code to execute ps (process status) and mpstat (CPU usage statistics)
        #Note:
            - execv( <path to command binary> , <array contain command name and its options> )
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main (void){

    int pid1,pid2;
    int status;

    /*
        start child 1 process
    */
    pid1 = fork();
    if(pid1 == 0){
        /* child code */
        printf("\n--------- Worker mpstat Started ---------\n");
        char *args[] = {"mpstat", "1", "1", NULL};
        execv("/usr/bin/mpstat", args);
        exit(1); /* if mpstat command failed */
    }
    else{
        /* Parent code */
    }

    /*
        start child 2 process
    */
    pid2 = fork();
    if(pid2 == 0){
        /* child code */
        printf("\n--------- Worker ps Started -------------\n");
        char *args[] = {"ps", "aux", NULL};  // aux to Show all active processes
        execv("/usr/bin/ps", args);
        exit(1); /* if ps command failed */
    }
    else{
        /* Parent code */
    }

    waitpid(pid1,&status,0);
    printf("\n--------- mpstat command finished --------- \n");

    waitpid(pid2,&status,0);
    printf("\n--------- ps command finished ------------- \n");

    return 0;
}