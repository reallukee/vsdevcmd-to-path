# VsDevCmd to Path

⚡ Aggiungi o rimuovi VsDevCmd dalla variabile %PATH%

> [Download!](https://github.com/reallukee/vsdevcmd-to-path/releases/latest)

```pwsh
.\VsDevCmd-to-Path.ps1 <Command> <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command <Command> `
                       -Environment <Environment> `
                       -Release <Release>
```



# Indice

* [Prerequisiti](#prerequisiti)
* [Utilizzo](#utilizzo)
* [Documentazione](#documentazione)
* [Autore](#autore)
* [Licenza](#licenza)



# Prerequisiti

* Windows
* PowerShell
* Visual Studio o Visual Studio Build Tools



# Utilizzo

* [Stato](#stato)
* [Aggiunta](#aggiunta)
* [Rimozione](#rimozione)



## Stato

> [Documentazione](#stato-1)

```pwsh
.\VsDevCmd-to-Path.ps1 Status <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Status `
                       -Environment <Environment> `
                       -Release <Release>
```



## Aggiunta

> [Documentazione](#aggiunta-1)

> [!IMPORTANT]
> Riavviare l'emulatore di terminale per rendere effettive le
> modifiche.<br />
> Le sessioni non riavviate continueranno a mostrare il
> comportamento precedente!

```pwsh
.\VsDevCmd-to-Path.ps1 Add <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Add `
                       -Environment <Environment> `
                       -Release <Release>
```



## Rimozione

> [Documentazione](#rimozione-1)

> [!IMPORTANT]
> Riavviare l'emulatore di terminale per rendere effettive le
> modifiche.<br />
> Le sessioni non riavviate continueranno a mostrare il
> comportamento precedente!

```pwsh
.\VsDevCmd-to-Path.ps1 Remove <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Remove `
                       -Environment <Environment> `
                       -Release <Release>
```



# Documentazione

* [Stato](#stato-1)
* [Aggiunta](#aggiunta-1)
* [Rimozione](#rimozione-1)



## Stato

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Restricted
> ```

### Sintassi

```pwsh
.\VsDevCmd-to-Path.ps1 Status <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Status `
                       -Environment <Environment> `
                       -Release <Release>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Release**

* `2026`: Visual Studio 2026 e Visual Studio Build Tools 2026
* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017
* `2015`: Visual Studio 2015 e Visual Studio Build Tools 2015

### Esempi

```pwsh
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 -Command Status -Environment User -Release 2022
```

```pwsh
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 -Command Status -Environment Machine -Release 2019
```



## Aggiunta

Aggiunge VsDevCmd alla variabile `%PATH%`

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Restricted
> ```

> [!WARNING]
> Nel caso in cui siano installati sia Visual Studio che
> Visual Studio Build Tools verranno aggiunti alla variabile
> `%PATH%` entrambi!

> [!IMPORTANT]
> `VsDevCmd-to-Path.ps1` crea un dump della variabile %PATH%
> prima di effettuare una modifica!
>
> La modifica della variabile `%PATH%` globale richiede i
> permessi di amministratore nella sessione di PowerShell.

### Sintassi

```pwsh
.\VsDevCmd-to-Path.ps1 Add <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Add `
                       -Environment <Environment> `
                       -Release <Release>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Release**

* `2026`: Visual Studio 2026 e Visual Studio Build Tools 2026
* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017
* `2015`: Visual Studio 2015 e Visual Studio Build Tools 2015

### Esempi

```pwsh
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 -Command Add -Environment User -Release 2022
```

```pwsh
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 -Command Add -Environment Machine -Release 2019
```



## Rimozione

Rimuove VsDevCmd dalla variabile `%PATH%`

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.<br />
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.<br />
>
> ```pwsh
> Set-ExecutionPolicy Restricted
> ```

> [!WARNING]
> Nel caso in cui siano installati sia Visual Studio che
> Visual Studio Build Tools verranno rimossi dalla variabile
> `%PATH%` entrambi!

> [!IMPORTANT]
> `VsDevCmd-to-Path.ps1` crea un dump della variabile %PATH%
> prima di effettuare una modifica!
>
> La modifica della variabile `%PATH%` globale richiede i
> permessi di amministratore nella sessione di PowerShell.

### Sintassi

```pwsh
.\VsDevCmd-to-Path.ps1 Remove <Environment> <Release>
```

```pwsh
.\VsDevCmd-to-Path.ps1 -Command Remove `
                       -Environment <Environment> `
                       -Release <Release>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Release**

* `2026`: Visual Studio 2026 e Visual Studio Build Tools 2026
* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017
* `2015`: Visual Studio 2015 e Visual Studio Build Tools 2015

### Esempi

```pwsh
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 -Command Remove -Environment User -Release 2022
```

```pwsh
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 -Command Remove -Environment Machine -Release 2019
```



# Autore

* [Luca Pollicino](https://github.com/reallukee)



# Licenza

Licenza [MIT](./LICENSE)
