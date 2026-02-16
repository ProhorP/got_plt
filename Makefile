CC = gcc
CFLAGS = -Wall -Wextra
AR = ar
ARFLAGS = rcs

# Исходные файлы
MAIN_SRC = main.c
PONG_SRC = pong.c
PONG_OBJ = pong.o
MAIN_OBJ = main.o

# Имена библиотек
STATIC_LIB = libpong.a
SHARED_LIB = libpong.so

# Имена исполняемых файлов
TARGET_STATIC = prog_static
TARGET_SHARED = prog_shared

.PHONY: all static shared clean

all: static shared

# Статическая линковка
static: $(TARGET_STATIC)

$(TARGET_STATIC): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(MAIN_OBJ) -L. -lpong -o $@

# Динамическая линковка (с RPATH для поиска .so в текущей папке)
shared: $(TARGET_SHARED)

$(TARGET_SHARED): $(MAIN_OBJ) $(SHARED_LIB)
	$(CC) $(MAIN_OBJ) -L. -lpong -Wl,-rpath,'$$ORIGIN' -o $@

# Статическая библиотека
$(STATIC_LIB): $(PONG_OBJ)
	$(AR) $(ARFLAGS) $@ $^

# Динамическая библиотека (с флагом -fPIC)
$(SHARED_LIB): $(PONG_OBJ)
	$(CC) -shared -fPIC -o $@ $^

# Компиляция объектного файла для pong (с -fPIC для динамической библиотеки)
$(PONG_OBJ): $(PONG_SRC) pong.h
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# Компиляция основного файла
$(MAIN_OBJ): $(MAIN_SRC) pong.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(PONG_OBJ) $(MAIN_OBJ) $(STATIC_LIB) $(SHARED_LIB) $(TARGET_STATIC) $(TARGET_SHARED)

