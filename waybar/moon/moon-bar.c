#include <stdio.h>
#include <time.h>


enum phase {
        NEW_MOON = 4,
        WAXING_CRESCENT = 5,
        FIRST_QUARTER = 6,
        WAXING_GIBBOUS = 7,
        FULL_MOON = 0,
        WANING_GIBBOUS = 1,
        LAST_QUARTER = 2,
        WANING_CRESCENT = 3
};

#define LUNAR_CYCLE 2551442.82118
#define FULL_MOON_ANCHOR 1741935300

static inline enum phase moon_phase(time_t epoch)
{
        double phase = (epoch - FULL_MOON_ANCHOR) / LUNAR_CYCLE;
        return (int)(phase * 8 + 8.5) % 8;
}

int main(void)
{
        time_t epoch = time(NULL);

        enum phase curr_phase = moon_phase(epoch);

        char *phase_emojis[8] = {
                "🌕",
                "🌖",
                "🌗",
                "🌘",
                "🌑",
                "🌒",
                "🌓",
                "🌔"
        };
        char *phase_strings[8] = {
                "Full moon",
                "Waning gibbous",
                "Last quarter",
                "Waning crescent",
                "New moon",
                "Waxing crescent",
                "First quarter",
                "Waxing gibbous"
        };

        printf("%s %s", phase_emojis[curr_phase], phase_strings[curr_phase]);

        return 0;
}

