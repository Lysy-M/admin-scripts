# Admin Scripts

Bezpieczne skrypty do diagnostyki i codziennej administracji systemami Linux i Windows.

Skrypty są celowo **read-only** lub wykonują wyłącznie niskiego ryzyka operacje diagnostyczne. Nie usuwają danych, nie zmieniają firewalla, nie resetują haseł i nie wykonują automatycznych aktualizacji.

## Bash
- `system-health.sh` — uptime, load, RAM, filesystem, błędne jednostki systemd, procesy.
- `service-status.sh` — stan wskazanych usług bez restartowania.
- `backup-check.sh` — wiek i rozmiar backupów bez modyfikacji danych.

## PowerShell
- `System-Inventory.ps1` — system, CPU, RAM, dyski, interfejsy.
- `EventLog-Summary.ps1` — ostatnie błędy i zdarzenia krytyczne.
- `Network-Diagnostics.ps1` — IP, DNS, brama i podstawowy test łączności.

## Bezpieczeństwo
Przed publikacją własnych skryptów usuń adresy IP, nazwy użytkowników i poświadczenia. Sekrety trzymaj poza repozytorium.
