## 🔌 Cartridge Power:

>[!NOTE]
>I cut the 5V plane coming from the 5v cart pin and bridged it with a 2.2Ω shunt resistor. Voltage was then measured accross the resistor to determine current used.
>These are screen captures from an emulator to show the game locations used for testing more clearly than photographs of the Gameboy screen:

![First 4 caps](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/6d922528-0f3c-4c97-99e5-d01528b2b422)
![2nd 4 caps](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/b1a7457f-cfad-41b0-9095-e542acc54dcc)
![Stats](https://github.com/sillyhatday/GAMEBOY-MBC5-CPLD-2MB/assets/65309612/23b83c93-8640-450c-a5b1-dcf386569fcc)

## Altera EPM3064A:

| Pokemon Shin Red | Current mA V1.0 | Current mA V1.1 | Current mA V2.0 | Current mA V3.0 |
| ---------------- | --------------- | --------------- | --------------- | --------------- |
| Intro Animation  | 30.9 | 31 | 17 | 26.4 |
| Title Screen Low | 30.3 | 30.2 | 17.6 | --- |
| Title Screen High | 35.8 | 35.7 | 23.9 | 30.9 |
| Overworld A | 32.7 | 33.1 | 21.3 | 28.4 |
| Overworld B | 30.2 | 30.5 | 18.9 | 26.1 |
| Overworld Talking | 38.7 | 38.9 | 27.6 | 33.6 |
| Pokemon Centre Nurse | 38.6 | 38.7 | 27.4 | 33.6 |
| Battle Scene | 34.8 | 34.8 | 23.3 | 30.3 |
| Pause Menu | 38.5 | 38.5 | 26.7 | 33.2 |
| Pokemon Stats | 38.7 | 38.7 | 27.1 | 33.5 |
| Average | 34.9 | 35.0 | 23.1 | 30.7 |

## Altera EPM3032A:

| Pokemon Shin Red     | Current mA V1.0 | Current mA V1.1 | Current mA V2.0 | Current mA V3.0 |
| ----------------     | --------------- | --------------- | --------------- | --------------- |
| Intro Animation      | 26.4            | 25.8            | 15.9            | 17.2 |
| Title Screen Low     | 25.9            | 25.1            | 15.6            | --- |
| Title Screen High    | 31.8            | 30.1            | 20.9            | 23.9 |
| Overworld A          | 29.0            | 28.1            | 18.5            | 20.2 |
| Overworld B          | 26.5            | 25.6            | 16.4            | 17.8 |
| Overworld Talking    | 34.9            | 34.1            | 24.5            | 26.2 |
| Pokemon Centre Nurse | 34.9            | 34.1            | 24.3            | 26.2 |
| Battle Scene         | 31.2            | 30.3            | 20.9            | 22.7 |
| Pause Menu           | 34.7            | 33.8            | 24.0            | 25.9 |
| Pokemon Stats        | 35.0            | 34.1            | 24.2            | 26.4 |
| Average              | 31.0            | 30.1            | 20.5            | 22.9 |

## Altera EPM7032S:

| Pokemon Shin Red     | Current mA V1.0 | Current mA V1.1 | Current mA V2.0 | Current mA V3.0 |
| ----------------     | --------------- | --------------- | --------------- | --------------- |
| Intro Animation      | ----            | 34.6            | 21.8            | 20.2 |
| Title Screen Low     | ----            | 34.2            | 21.6            | ---- |
| Title Screen High    | ----            | 51.0            | 46.4            | 27.8 |
| Overworld A          | ----            | 37.1            | 24.9            | 23.7 |
| Overworld B          | ----            | 34.7            | 22.7            | 21.2 |
| Overworld Talking    | ----            | 52.9            | 41.3            | 30.2 |
| Pokemon Centre Nurse | ----            | 53.0            | 41.3            | 29.7 |
| Battle Scene         | ----            | 39.7            | 27.9            | 26.3 |
| Pause Menu           | ----            | 42.9            | 30.9            | 29.7 |
| Pokemon Stats        | ----            | 43.0            | 30.9            | 30.1 |
| Average              | ----            | 42.3            | 31.0            | 26.5 |

## Atmel ATF1502A:

| Pokemon Shin Red     | Current mA V1.0 | Current mA V1.1 | Current mA V2.0 | Current mA V3.0 |
| ----------------     | --------------- | --------------- | --------------- | --------------- |
| Intro Animation      | ----            | ----            | 36.8            | 40.0 |
| Title Screen Low     | ----            | ----            | 36.6            | ---- |
| Title Screen High    | ----            | ----            | 55.9            | 47.7 |
| Overworld A          | ----            | ----            | 39.8            | ---- |
| Overworld B          | ----            | ----            | 37.6            | ---- |
| Overworld Talking    | ----            | ----            | 55.9            | ---- |
| Pokemon Centre Nurse | ----            | ----            | 56.0            | ---- |
| Battle Scene         | ----            | ----            | 42.7            | ---- |
| Pause Menu           | ----            | ----            | 45.5            | 47.9 |
| Pokemon Stats        | ----            | ----            | 46.3            | 48.1 |
| Average              | ----            | ----            | 46.0*           | 45.9** |

**Buggy and strange flashing behaviour*
***RAM refuses to flash properly under sustained writes*
