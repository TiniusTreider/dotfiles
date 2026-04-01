CC = gcc
CFLAGS = -Wall -Wextra -O2

executable = battery-bar
sources = battery-bar.c
objects = battery-bar.o

.PHONY: all clean

all: $(executable)

$(objects): $(sources)
	$(CC) $(CFLAGS) -c $^ -o $@

$(executable): $(objects)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f $(objects) $(executable)

