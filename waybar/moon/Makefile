CC = gcc
CFLAGS = -Wall -Wextra -O2

executable = moon-bar
sources = moon-bar.c
objects = moon-bar.o

.PHONY: all clean

all: $(executable)

$(objects): $(sources)
	$(CC) $(CFLAGS) -c $^ -o $@

$(executable): $(objects)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f $(objects) $(executable)

