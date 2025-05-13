# VsDevCmd to Path

⚡ Aggiungi o rimuovi VsDevCmd dalla variabile %PATH%

> [Download!](https://github.com/reallukee/vsdevcmd-to-path/releases/latest)

```
.\VsDevCmd-to-Path.ps1 <Operation> <Environment> <Version>
```

```
-Operation   : [Status|Add|Remove]
-Environment : [User|Machine]
-Version     : [2017|2019|2022]
```

```
VsDevCmd
```



# Indice

* [Prerequisiti](#prerequisiti)
* [Utilizzo](#utilizzo)
* [Documentazione](#documentazione)
* [Autore](#autore)
* [Licenza](#licenza)



# Prerequisiti

* Windows 7 SP1 (O versioni successive)

* PowerShell

  > [!TIP]
  > Si consiglia di utilizzare [PowerShell 7](https://aka.ms/PSWindows)!

* Visual Studio 2017 (O versioni successive)

    | Nome               | Supporto |
    | :----------------- | :------: |
    | Visual Studio 2022 | ✅        |
    | Visual Studio 2019 | ✅        |
    | Visual Studio 2017 | ✅        |
    | Visual Studio 2015 | ❌        |
    | Visual Studio 2013 | ❌        |
    | Visual Studio 2012 | ❌        |
    | Visual Studio 2010 | ❌        |

* Visual Studio Build Tools 2017 (O versioni successive)

    | Nome                           | Supporto |
    | :----------------------------- | :------: |
    | Visual Studio Build Tools 2022 | ✅        |
    | Visual Studio Build Tools 2019 | ✅        |
    | Visual Studio Build Tools 2017 | ✅        |



# Utilizzo

* [Stato](#stato)
* [Aggiunta](#aggiunta)
* [Rimozione](#rimozione)



## Stato

> [Documentazione](#stato-1)

| Comando                                      |
| :------------------------------------------- |
| `.\VsDevCmd-to-Path.ps1 Status User 2022`    |
| `.\VsDevCmd-to-Path.ps1 Status User 2019`    |
| `.\VsDevCmd-to-Path.ps1 Status User 2017`    |
| `.\VsDevCmd-to-Path.ps1 Status Machine 2022` |
| `.\VsDevCmd-to-Path.ps1 Status Machine 2019` |
| `.\VsDevCmd-to-Path.ps1 Status Machine 2017` |



## Aggiunta

> [Documentazione](#aggiunta-1)

> [!IMPORTANT]
> Riavviare l'emulatore di terminale per rendere attive le
> modifiche. Le sessioni non riavviate continueranno a
> mostrare il comportamento precedente!

| Comando                                   |
| :---------------------------------------- |
| `.\VsDevCmd-to-Path.ps1 Add User 2022`    |
| `.\VsDevCmd-to-Path.ps1 Add User 2019`    |
| `.\VsDevCmd-to-Path.ps1 Add User 2017`    |
| `.\VsDevCmd-to-Path.ps1 Add Machine 2022` |
| `.\VsDevCmd-to-Path.ps1 Add Machine 2019` |
| `.\VsDevCmd-to-Path.ps1 Add Machine 2017` |



## Rimozione

> [Documentazione](#rimozione-1)

> [!IMPORTANT]
> Riavviare l'emulatore di terminale per rendere attive le
> modifiche. Le sessioni non riavviate continueranno a
> mostrare il comportamento precedente!

| Comando                                      |
| :------------------------------------------- |
| `.\VsDevCmd-to-Path.ps1 Remove User 2022`    |
| `.\VsDevCmd-to-Path.ps1 Remove User 2019`    |
| `.\VsDevCmd-to-Path.ps1 Remove User 2017`    |
| `.\VsDevCmd-to-Path.ps1 Remove Machine 2022` |
| `.\VsDevCmd-to-Path.ps1 Remove Machine 2019` |
| `.\VsDevCmd-to-Path.ps1 Remove Machine 2017` |



# Documentazione

* [Stato](#stato-1)
* [Aggiunta](#aggiunta-1)
* [Rimozione](#rimozione-1)



## Stato

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Restricted
> ```



### Sintassi

```
.\VsDevCmd-to-Path.ps1 Status <Environment> <Version>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Version**

* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017



### Esempi

```powershell
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 Status User 2022
```

```powershell
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 Status Machine 2019
```



## Aggiunta

Aggiunge VsDevCmd alla variabile `%PATH%`

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
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

```
.\VsDevCmd-to-Path.ps1 Add <Environment> <Version>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Version**

* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017



### Esempi

```powershell
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 Add User 2022
```

```powershell
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 Add Machine 2019
```



## Rimozione

Rimuove VsDevCmd dalla variabile `%PATH%`

Leggere i [prerequisiti](#prerequisiti)!

### Avvertenze

> [!IMPORTANT]
> L'esecuzione degli script PowerShell potrebbe essere
> disabilitata per impostazione predefinita.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Unrestricted
> ```
>
> Una volta terminata la modifica, ricordati di disattivare
> l'esecuzione degli script PowerShell.
> Esegui il seguente comando in una sessione di PowerShell
> in modalità amministratore.
>
> ```powershell
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

```
.\VsDevCmd-to-Path.ps1 Remove <Environment> <Version>
```

**Environment**

* `User`: Operazione per l'utente corrente
* `Machine`: Operazione per tutti gli utenti

**Version**

* `2022`: Visual Studio 2022 e Visual Studio Build Tools 2022
* `2019`: Visual Studio 2019 e Visual Studio Build Tools 2019
* `2017`: Visual Studio 2017 e Visual Studio Build Tools 2017



### Esempi

```powershell
# Per l'utente corrente (Visual Studio 2022)
.\VsDevCmd-to-Path.ps1 Remove User 2022
```

```powershell
# Per tutti gli utenti (Visual Studio 2019)
.\VsDevCmd-to-Path.ps1 Remove Machine 2019
```



# Autore

* [Luca Pollicino](https://github.com/reallukee)



# Licenza

Licenza [MIT](./LICENSE)
