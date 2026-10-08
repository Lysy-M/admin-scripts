# Admin Scripts

Praktyczne skrypty Bash i PowerShell do diagnostyki oraz codziennej administracji systemami Linux i Windows.

Repozytorium zawiera celowo bezpieczne przykłady narzędzi administracyjnych. Obecne skrypty wykonują operacje diagnostyczne i odczytowe — nie usuwają danych, nie zmieniają konfiguracji firewalla, nie resetują haseł i nie wykonują automatycznych aktualizacji.

## Bash

### `system-health.sh`

Podstawowa diagnostyka hosta Linux:

- data i czas,
- hostname,
- uptime i load average,
- wykorzystanie RAM,
- filesystem,
- błędne jednostki systemd,
- procesy wykorzystujące najwięcej CPU i RAM,
- temperatury, jeśli dostępny jest `lm-sensors`.

Uruchomienie:

    ./bash/system-health.sh

### `service-status.sh`

Sprawdza stan wybranych usług systemd bez wykonywania restartów.

Domyślnie sprawdzane są m.in.:

- SSH,
- cron,
- Docker,
- Tailscale,
- Zabbix Agent 2,
- Wazuh Agent.

Uruchomienie:

    ./bash/service-status.sh

### `backup-check.sh`

Sprawdza zawartość wskazanego katalogu backupu:

- najnowsze pliki,
- całkowity rozmiar,
- pliki starsze niż 30 dni.

Nie usuwa ani nie modyfikuje danych.

Domyślny katalog:

    ./bash/backup-check.sh

Własny katalog:

    ./bash/backup-check.sh /ścieżka/do/backupu

## PowerShell

### `System-Inventory.ps1`

Zbiera podstawowe informacje o systemie Windows:

- wersja systemu,
- czas ostatniego uruchomienia,
- CPU,
- RAM,
- dyski,
- interfejsy sieciowe.

Uruchomienie:

    .\powershell\System-Inventory.ps1

### `EventLog-Summary.ps1`

Wyświetla zdarzenia `Critical` i `Error` z logów:

- System,
- Application.

Domyślnie analizowane są ostatnie 24 godziny.

Przykład:

    .\powershell\EventLog-Summary.ps1 -Hours 48 -MaxEvents 100

### `Network-Diagnostics.ps1`

Diagnostyka konfiguracji sieciowej Windows:

- stan kart sieciowych,
- konfiguracja IPv4,
- serwery DNS,
- trasa domyślna,
- test łączności przez `Test-NetConnection`.

Przykład:

    .\powershell\Network-Diagnostics.ps1

Test wskazanego hosta:

    .\powershell\Network-Diagnostics.ps1 -TestHost 1.1.1.1

## Zasady bezpieczeństwa

Repozytorium nie powinno zawierać:

- rzeczywistych haseł,
- tokenów API,
- kluczy prywatnych,
- danych uwierzytelniających,
- wewnętrznej adresacji infrastruktury,
- danych klientów.

Dane specyficzne dla środowiska powinny być przekazywane jako parametry lub zastępowane wartościami dokumentacyjnymi przed publikacją.

## Zakres projektu

Repozytorium rozwijam jako część mojego portfolio Administratora IT i homelabu.

Powiązane projekty:

- [Cybersecurity & Infrastructure Homelab](https://github.com/Lysy-M/cybersecurity-infrastructure-homelab)
- [Windows Server / Active Directory / VirtualBox Lab](https://github.com/Lysy-M/windows-server-ad-virtualbox-lab)

## Autor

**Michał Łysiński**

Administrator IT | Linux | Windows Server | Active Directory | Proxmox | Monitoring | Security | Automation
