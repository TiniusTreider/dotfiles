#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define CAPACITY_PATH "/sys/class/power_supply/BAT1/capacity"
#define STATUS_PATH "/sys/class/power_supply/BAT1/status"

#define OPEN_ERROR "Failed to open file"
#define READ_ERROR "Failed to read file"
#define CLOSE_ERROR "Failed to close file"

static inline void error(char *message, char *path)
{
        fprintf(stderr, "%s: %s\n", message, path);
        exit(EXIT_FAILURE);
}

static inline void read_files(int *capacity, char *status)
{
        FILE *cf = fopen(CAPACITY_PATH, "r");
        if (cf == NULL)
                error(OPEN_ERROR, CAPACITY_PATH);

        if (fscanf(cf, "%d", capacity) != 1)
                error(READ_ERROR, CAPACITY_PATH);

        if (fclose(cf) != 0)
                error(CLOSE_ERROR, CAPACITY_PATH);

        FILE *sf = fopen(STATUS_PATH, "r");
        if (sf == NULL)
                error(OPEN_ERROR, STATUS_PATH);

        if (fscanf(sf, "%31s", status) != 1)
                error(READ_ERROR, STATUS_PATH);

        if (fclose(sf) != 0)
                error(CLOSE_ERROR, STATUS_PATH);
}

#define BAR_WIDTH 8
#define BLOCK_COUNT 8

enum state {
        FULL,
        CHARGING,
        DISCHARGING,
};

int main(void)
{
        int capacity;
        char status[32];
        read_files(&capacity, status);

        enum state status_state;

        if (strcmp(status, "Full") == 0 || strcmp(status, "Not") == 0)
                status_state = FULL;
        else if (strcmp(status, "Charging") == 0)
                status_state = CHARGING;
        else if (strcmp(status, "Discharging") == 0)
                status_state = DISCHARGING;
        else
                error("Invalid status", status);

        char status_char[4];

        switch (status_state) {
                case FULL:
                        strcpy(status_char, "→"); break;
                case CHARGING:
                        strcpy(status_char, "↑"); break;
                case DISCHARGING:
                        strcpy(status_char, "↓"); break;
                default:
                        error("Invalid status", status);
        }

        const char block[] = "█";
        const size_t block_size = sizeof(block) - 1;

        const char *blocks[BLOCK_COUNT] = {
                " ",
                "▏",
                "▎",
                "▍",
                "▌",
                "▋",
                "▊",
                "▉",
        };

        const int hundred = capacity == 100;
        const int slices = BAR_WIDTH * BLOCK_COUNT * capacity / 100;
        const int full = slices / 8;
        const int empty = BAR_WIDTH - full - !hundred;
        const char *middle = hundred ? "" : blocks[slices % BLOCK_COUNT];

        char start_string[BAR_WIDTH * block_size + 1];
        start_string[full * block_size] = '\0';

        char end_string[BAR_WIDTH + 1];
        end_string[empty] = '\0';
        memset(end_string, ' ', empty);

        for (int i = 0; i < full; i++)
        {
                memcpy(start_string + i * block_size, &block, block_size);
        }

        printf("[%s%s%s] %d%% %s", start_string, middle, end_string, capacity, status_char);

        return 0;
}

