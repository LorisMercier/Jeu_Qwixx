
CORE = core/des.cpp core/fiche.cpp core/jeu.cpp core/ligne.cpp

SRCS_TXT = $(CORE) txt/txtJeu.cpp txt/winTxt.cpp txt/mainTexte.cpp
FINAL_TARGET_TXT = qwixx_txt
#DEFINE_TXT = -DJEU_TXT

SRCS_SDL = $(CORE) sdl2/sdlJeu.cpp sdl2/image.cpp sdl2/mainSdl.cpp
FINAL_TARGET_SDL = qwixx_sdl
#DEFINE_SDL = -DJEU_SDL

SRCS_TEST = $(CORE) test/mainTest.cpp
FINAL_TARGET_TEST = qwixx_test

ifeq ($(OS),Windows_NT)
	INCLUDE_DIR_SDL = 	-Iextern/SDL2_mingw-cb20/SDL2-2.0.12/x86_64-w64-mingw32/include/SDL2 \
						-Iextern/SDL2_mingw-cb20/SDL2_ttf-2.0.15/x86_64-w64-mingw32/include/SDL2 \
						-Iextern/SDL2_mingw-cb20/SDL2_image-2.0.5/x86_64-w64-mingw32/include/SDL2 \
						-Iextern/SDL2_mingw-cb20/SDL2_mixer-2.0.4/x86_64-w64-mingw32/include/SDL2

	LIBS_SDL = -Lextern \
			-Lextern/SDL2_mingw-cb20/SDL2-2.0.12/x86_64-w64-mingw32/lib \
			-Lextern/SDL2_mingw-cb20/SDL2_ttf-2.0.15/x86_64-w64-mingw32/lib \
			-Lextern/SDL2_mingw-cb20/SDL2_image-2.0.5/x86_64-w64-mingw32/lib \
			-Lextern/SDL2_mingw-cb20/SDL2_mixer-2.0.4/x86_64-w64-mingw32/lib \
			-lmingw32 -lSDL2main -lSDL2.dll -lSDL2_ttf.dll -lSDL2_image.dll -lSDL2_mixer.dll

else
	INCLUDE_DIR_SDL = -I/usr/include/SDL2
	LIBS_SDL = -lSDL2 -lSDL2_ttf -lSDL2_image -lSDL2_mixer
endif

CC					= g++
LD 					= g++
LDFLAGS  			=
CPPFLAGS 			= -Wall -ggdb   #-O2   # pour optimiser
OBJ_DIR 			= obj
SRC_DIR 			= src
BIN_DIR 			= bin
INCLUDE_DIR			= -Isrc -Isrc/core -Isrc/sdl2 -Itxt

default: make_dir $(BIN_DIR)/$(FINAL_TARGET_TXT) $(BIN_DIR)/$(FINAL_TARGET_SDL) $(BIN_DIR)/$(FINAL_TARGET_TEST)

qwixx_txt: make_dir $(BIN_DIR)/$(FINAL_TARGET_TXT)
qwixx_sdl: make_dir $(BIN_DIR)/$(FINAL_TARGET_SDL)
qwixx_test: make_dir $(BIN_DIR)/$(FINAL_TARGET_TEST)

make_dir:
ifeq ($(OS),Windows_NT)
	if not exist $(OBJ_DIR) mkdir $(OBJ_DIR) $(OBJ_DIR)\txt $(OBJ_DIR)\sdl2 $(OBJ_DIR)\core $(OBJ_DIR)\test
else
	test -d $(OBJ_DIR) || mkdir -p $(OBJ_DIR) $(OBJ_DIR)/txt $(OBJ_DIR)/sdl2 $(OBJ_DIR)/core $(OBJ_DIR)/test
endif

$(BIN_DIR)/$(FINAL_TARGET_TXT): $(SRCS_TXT:%.cpp=$(OBJ_DIR)/%.o)
	$(LD) $+ -o $@ $(LDFLAGS)

$(BIN_DIR)/$(FINAL_TARGET_SDL): $(SRCS_SDL:%.cpp=$(OBJ_DIR)/%.o)
	$(LD) $+ -o $@ $(LDFLAGS) $(LIBS_SDL)

$(BIN_DIR)/$(FINAL_TARGET_TEST): $(SRCS_TEST:%.cpp=$(OBJ_DIR)/%.o)
	$(LD) $+ -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CC) -c $(CPPFLAGS) $(INCLUDE_DIR_SDL) $(INCLUDE_DIR) $< -o $@

clean:
ifeq ($(OS),Windows_NT)
	del /f $(OBJ_DIR)\txt\*.o $(OBJ_DIR)\sdl2\*.o $(OBJ_DIR)\core\*.o $(BIN_DIR)\$(FINAL_TARGET_TXT).exe $(BIN_DIR)\$(FINAL_TARGET_SDL).exe $(BIN_DIR)\$(FINAL_TARGET_TEST).exe
else
	rm -rf $(OBJ_DIR) $(BIN_DIR)/$(FINAL_TARGET_TXT) $(BIN_DIR)/$(FINAL_TARGET_SDL) $(BIN_DIR)/$(FINAL_TARGET_TEST)
endif

