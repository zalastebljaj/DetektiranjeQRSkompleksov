# Detektiranje QRS kompleksov

Projekt je implementacija algoritma iz članka z naslovom [A Moving Average based Filtering System with its Application to Real-time QRS Detection](https://ieeexplore.ieee.org/document/1291223) avtorjev H. C. Chena in S. W. Chena ter njegova izboljšava. Z njim želimo čim bolje detektirati QRS komplekse oziroma srčne utripe. Algoritem je implementiran v programskem jeziku MATLAB.

## Baze posnetkov srčnih utripov
Preizkušen je na dveh bazah podatkov, ki jih lahko najdemo na spletni strani [PhysioNeta](https://physionet.org/). To sta bazi [Long-Term ST Database](https://physionet.org/content/ltstdb/1.0.0/) in [MIT-BIH Arrhythmia Database](https://physionet.org/content/mitdb/1.0.0/). Za pravilno delovanje algoritma morajo biti v mapi s kodo tudi vse datoteke s končnicami `.dat`, `.hea` in `.asc` za posnetke, ki jih želimo analizirati. 

## Koda
Glavni del kode algoritma se nahaja v datoteki `QRSDetectA.m`, če želimo program pognati, pa je treba zagnati skripto `RunAll.m`. Poleg MATLAB-ovih datotek so v mapi tudi pomožne knjižnice za upravljanje z datotekami in podatki ter statistično analizo. Delovanje algoritma z izboljšavami, rezultati in diskusija so predstavljeni v `Porocilo.pdf`.

## Rezultati
Rezultati, ki jih vrne program, so na voljo v datoteki `results.txt`. Dobljeni so z uporabo algoritma na bazi LTST DB, v kateri je 86 posnetkov. Kot je zapisano v poročilu, so rezultati zelo dobri. Za merilo sta uporabljeni občutljivost in pozitivna prediktivnost, ki znašata 99.62 % in 99.15 %.
