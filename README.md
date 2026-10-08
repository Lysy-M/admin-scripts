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

## Rozszerzony zestaw narzędzi administracyjnych

Repozytorium zawiera także dodatkowe narzędzia diagnostyczne przeznaczone do administracji Linux, Proxmox VE, Windows Server oraz usług monitoringu.

### Linux / Proxmox

- `proxmox-node-health.sh` — kontrola wersji Proxmox VE, klastra, storage, VM/CT, pamięci, filesystemu i błędnych usług systemd.
- `zabbix-agent-check.sh` — diagnostyka Zabbix Agent / Zabbix Agent 2, portów oraz ostatnich logów.
- `wazuh-agent-check.sh` — diagnostyka usługi i procesów Wazuh Agent oraz ostatnich logów.
- `docker-health.sh` — stan Docker Engine, kontenerów, health status oraz wykorzystanie przestrzeni.
- `linux-network-diagnostics.sh` — interfejsy, routing, DNS, porty nasłuchujące i podstawowy test łączności.
- `backup-verification.sh` — kontrola obecności i wieku najnowszych kopii zapasowych.
- `ssh-service-audit.sh` — odczytowa kontrola SSH, listenera i wybranych parametrów efektywnej konfiguracji `sshd`.
- `system-inventory.sh` — podstawowa inwentaryzacja systemu Linux, CPU, RAM, storage i sieci.

### Windows / Active Directory

- `Windows-Server-Health.ps1` — stan Windows Server, pamięci, dysków, kluczowych usług oraz ostatnich błędów systemowych.
- `AD-DNS-Diagnostics.ps1` — diagnostyka domeny Active Directory, kontrolerów domeny, replikacji oraz DNS.
- `WinRM-RDP-Connectivity.ps1` — test DNS, ICMP oraz dostępności portów WinRM, RDP i SSH wskazanego hosta.
- `Incident-Log-Collection.ps1` — zbieranie zdarzeń System, Application i Security oraz informacji o usługach i portach na potrzeby diagnostyki incydentu.

### Charakter narzędzi

Skrypty w tej części repozytorium są przeznaczone przede wszystkim do diagnostyki i audytu. Nie wykonują automatycznych restartów hostów, zmian firewalla, resetów haseł ani usuwania danych.

Część skryptów wymaga odpowiedniego środowiska do pełnego działania, np.:

- Proxmox VE dla `proxmox-node-health.sh`,
- Docker Engine dla `docker-health.sh`,
- Wazuh/Zabbix Agent dla ich diagnostyki,
- Windows Server dla narzędzi serwerowych,
- modułu Active Directory / RSAT dla pełnego zakresu `AD-DNS-Diagnostics.ps1`.

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
