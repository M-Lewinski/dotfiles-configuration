#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int const MIN = 10;
int const MAX = 100;

/**
*   Print help information and exit the program.
*/
void showHelp(){
    printf("\n\tProgram adjusting backlight volume by modyfing values in specific files.");
    printf("\n\tIn order to decrease exectuion time,\
    all values are stored as constant values rather than config file.");
    printf("\n\tAvailable parameters:");
    printf("\n\t\t-h\t--help\t show help information\n");
    printf("\n\t\t-i\t--increase=VALUE\t increase backlight volume by value provided\n");
    printf("\n\t\t-d\t--decrease=VALUE\t decrease backlight volume by value provided\n");
    printf("\n\t\t-s\t--set=VALUE\t set backlight volume with value provided\n");
    printf("\n\n\tWritten by Michał Lewinski - 2018\n\n");
    exit(0);
}

/**
*   Check if value for parameter exists and if it's value is integer.
*   If value is not an integer than program exits with error.
*   
*   @count      index of current parameter
*   @argc       table of all parameters
*   @argv       amount of parameters passed to program
*   @return     value of parameter that was converted to integer.
*/
int checkParamValue(int count, char** argc, int argv){
    if (count+1 >= argv){
        fprintf(stderr,"\n Parameter value missing\n");
        exit(1); 
    }
    char* tmp;
    int value = strtol(argc[count+1],&tmp,10);
    if (strcmp(tmp,"")!=0){
        fprintf(stderr,"\n Parameter is not a integer value %s\n",tmp);
        exit(2);
    }
    return value;
}

/**
*   Function parses parameter passed to program.
*   Based on a value of parameter, backlight volume is modified accordingly.
*   
*   @count      index of current parameter
*   @argc       table of all parameters
*   @argv       amount of parameters passed to program
*   @return     modified value of backlight.
*/
int parseParameters(int backlight, int count, char** argc, int argv){
    char* param = argc[count];
    if (!strcmp("-h",param) || !strcmp("--help", param))
        showHelp();
    else if (!strcmp("-i",param) || !strcmp("--increase",param))
        backlight += checkParamValue(count,argc,argv);
    else if (!strcmp("-d",param) || !strcmp("--decrease",param))
        backlight -= checkParamValue(count,argc,argv);
    else if (!strcmp("-s",param) || !strcmp("--set",param))
        backlight = checkParamValue(count,argc,argv);
    else {
        fprintf(stderr,"\nThere is no such parameter %s\n",param);
        exit(1);
    }
    return backlight;
}

/*
*   Function reades integer value from file.
*   If it's not a integer than it exists with error.
*
*   @filename   Name of a file to read from.
*   @return     integer that was read from file.
*/
int readIntFromFile(char* filename){
    FILE *fd = fopen(filename, "r");
    if(!fd){
        fprintf(stderr,"\nCouldn't open file for reading %s\n",filename);
        exit(3);
    }
    char* buffer = NULL;
    long unsigned int size = 0; 
    getline(&buffer, &size, fd);
    if(!buffer) exit(3);
    char *tmp;
    int value = strtol(buffer,&tmp,10);
    fclose(fd);
    return value; 
}

/*
*   Function writes integer value to file.
*   @filename   Name of a file to read from.
*/
void writeIntToFile(char* filename, int value){
    FILE *fd = fopen(filename,"w");
    if (!fd){
        fprintf(stderr,"\nCouldn't open file to write value %s\n",filename);
        exit(3);
    }
    fprintf(fd,"%d\n",value);
    fclose(fd);
}

int main(int argv, char** argc){
    int i;
    int backlight = readIntFromFile("/sys/class/backlight/intel_backlight/brightness");
    int maxbacklight = readIntFromFile("/sys/class/backlight/intel_backlight/max_brightness");
    printf("Value: %d\n",backlight);
    float scale = maxbacklight/100.0;
    printf("Scale %f\n",scale);
    backlight = ceil(backlight/scale);
    printf("Proc: %d\n",backlight);
    for(i = 1; i < argv; i++){
        backlight = parseParameters(backlight,i,argc,argv);
        i++;
    }
    if (backlight > MAX) backlight = MAX;
    if (backlight < MIN) backlight = MIN;
    printf("\nFinal value %d\n",backlight);
    backlight *= scale; 
    printf("\nFinal proc %d\n",backlight);
    writeIntToFile("/sys/class/backlight/intel_backlight/brightness",backlight);
    return 0;
}