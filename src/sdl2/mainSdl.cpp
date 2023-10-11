#include "sdlJeu.h"
#include <stdlib.h> //Pour srand();
#include <iostream>
#include <time.h>


int main(int argc, char *argv[]){
    sdlJeu sdl;
    srand(time(NULL)); 
    sdl.sdlBoucle();
    return 0;
}