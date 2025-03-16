# VsDevCmd to Path

⚡ Aggiunge (o rimuove) VsDevCmd alla variabile Path

```batch
> VsDevCmd
```



# Aggiunta

> [!TIP]
> Si consiglia di utilizzare [PowerShell 7+](https://aka.ms/PSWindows).
>
> È possibile installare PowerShell 7 utilizzando `winget`.
>
> ```cmd
> winget install Microsoft.PowerShell
> ```
>

> [!IMPORTANT]
> L'esecuzione di Script PowerShell potrebbe essere disattivata per impostazione
> predefinita.
> Esegui il seguente comando in una sessione di PowerShell in
> modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Unrestricted
> ```
>
> Terminata la modifica ricordarsi di disattivare l'esecuzione degli Script
> PowerShell.
> Esegui il seguente comando in una sessione di PowerShell in
> modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Restricted
> ```

Eseguire lo script PowerShell:

> [!IMPORTANT]
> `VsDevCmd-to-Path.ps1` crea un dump della variabile %PATH%
> prima di effettuare una modifica!
>
> La modifica della variabile `%PATH%` globale richiede i
> permessi di amministratore nella sessione di PowerShell.

```powershell
# Per l'Utente
.\VsDevCmd-to-Path.ps1 Add User

# Per tutti gli Utenti
.\VsDevCmd-to-Path.ps1 Add Machine
```



# Rimozione

> [!TIP]
> Si consiglia di utilizzare [PowerShell 7+](https://aka.ms/PSWindows).
>
> È possibile installare PowerShell 7 utilizzando `winget`.
>
> ```cmd
> winget install Microsoft.PowerShell
> ```
>

> [!IMPORTANT]
> L'esecuzione di Script PowerShell potrebbe essere disattivata per impostazione
> predefinita.
> Esegui il seguente comando in una sessione di PowerShell in
> modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Unrestricted
> ```
>
> Terminata la modifica ricordarsi di disattivare l'esecuzione degli Script
> PowerShell.
> Esegui il seguente comando in una sessione di PowerShell in
> modalità amministratore.
>
> ```powershell
> Set-ExecutionPolicy Restricted
> ```

Eseguire lo script PowerShell:

> [!IMPORTANT]
> `VsDevCmd-to-Path.ps1` crea un dump della variabile %PATH%
> prima di effettuare una modifica!
>
> La modifica della variabile `%PATH%` globale richiede i
> permessi di amministratore nella sessione di PowerShell.

```powershell
# Per l'Utente
.\VsDevCmd-to-Path.ps1 Remove User

# Per tutti gli Utenti
.\VsDevCmd-to-Path.ps1 Remove Machine
```



# Autore

* [Luca Pollicino](https://github.com/reallukee)



# Licenza

Licenza [MIT](./LICENSE)
