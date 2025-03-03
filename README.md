# 🎬 FFmpeg Streamer Batch

Tento projekt umožňuje streamovanie videí na RTMP server pomocou **FFmpeg** v prostredí **Windows**. Používa **Batch script** na spracovanie viacerých video súborov a umožňuje výber rozlíšenia aj dynamické načítanie súborov z priečinka.

---

## 📌 Funkcionalita
✅ **Podpora viacerých rozlíšení** (1080p, 720p, 480p)  
✅ **Možnosť načítať videá z priečinka alebo súboru**  
✅ **Automatické vytvorenie zoznamu vstupných súborov**  
✅ **Použitie NVIDIA NVENC pre hardvérovú akceleráciu**  
✅ **RTMP streamovanie s optimalizovaným bitrate**  

---

## 📥 Inštalácia

### 1️⃣ **Inštalácia Scoop package manager** (Odporúčané)
Scoop je jednoduchý balíčkový manažér pre Windows. Ak ho ešte nemáš, nainštaluj ho pomocou PowerShellu:

```powershell
irm get.scoop.sh | iex
```

👉 **Over, či je Scoop správne nainštalovaný**:  
```powershell
scoop --version
```

---

### 2️⃣ **Inštalácia FFmpeg s podporou NVIDIA CUDA cez Scoop**
Scoop obsahuje repozitár **extras**, ktorý poskytuje verziu **FFmpeg s NVENC**. Pridaj tento repozitár a nainštaluj FFmpeg:

```powershell
scoop bucket add extras
scoop install ffmpeg-nvidia
```

👉 Over, či sa FFmpeg správne nainštaloval:
```powershell
ffmpeg -version
```
Ak vidíš `ffmpeg-nvidia` a podporu `h264_nvenc`, všetko je nastavené správne. ✅

---

### 3️⃣ **Inštalácia NVIDIA ovládačov a CUDA SDK**  
Ak chceš používať **NVENC akceleráciu**, potrebuješ najnovšie NVIDIA ovládače a **CUDA Toolkit**:

🔹 **Stiahnutie ovládačov**: [NVIDIA Drivers](https://www.nvidia.com/download/index.aspx)  
🔹 **Stiahnutie CUDA Toolkit**: [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)  

👉 **Overenie podpory CUDA**:  
Otvoriť **PowerShell** a zadať:
```powershell
nvidia-smi
```
Ak sa zobrazí zoznam GPU a informácie o CUDA, všetko je správne nakonfigurované. ✅

---

### 🚀 Použitie

#### 1️⃣ **Spustenie s predvoleným nastavením (720p)**
Stačí spustiť skript:
```sh
play.bat
```
Týmto sa použijú videá zo súboru `playlist.txt` a predvolené rozlíšenie **720p**.

---

#### 2️⃣ **Výber rozlíšenia (1080p, 720p, 480p)**
Ak chceš špecifikovať rozlíšenie, použiješ:
```sh
play.bat 1080p
```
alebo
```sh
play.bat 480p
```
⚠️ **Ak zadáš neplatné rozlíšenie, skript sa ukončí s chybovou správou.**

---

#### 3️⃣ **Streamovanie videí z konkrétneho priečinka**
Ak chceš streamovať všetky videá z určitého priečinka:
```sh
play.bat 1080p "C:\Users\janko\Videos"
```
💡 **Podporované formáty:** `.mov`, `.mkv`, `.mp4`, `.avi`  

#### 📂 **Použitie lokálneho priečinka (kde je skript)**
Ak sú videá v tom istom priečinku ako `play.bat`, môžeš použiť:  
```sh
play.bat 1080p "."
```

---

## 🔧 Konfigurácia

### 📝 **Úprava zoznamu videí manuálne**
Ak nechceš načítavať videá z priečinka, môžeš upraviť `playlist.txt`:
```
C:\cesta\k\suboru1.mp4
C:\cesta\k\suboru2.mkv
C:\cesta\k\suboru3.avi
```
Potom spustíš:
```sh
play.bat 720p
```

---

## 📊 Bitrate nastavenia
Každé rozlíšenie používa optimálne hodnoty:

| Rozlíšenie | Bitrate  | Maxrate | Bufsize  |
|------------|---------|---------|----------|
| **1080p**  | 8000k   | 8000k   | 16000k   |
| **720p**   | 3000k   | 3000k   | 6000k    |
| **480p**   | 1500k   | 1500k   | 3000k    |

---

## 🛠 Požiadavky
✅ **Windows 10/11**  
✅ **FFmpeg (s NVENC akceleráciou pre NVIDIA GPU)**  
✅ **RTMP server (napr. Nginx s RTMP modulom alebo Twitch/Youtube)**  

---

## 📝 Licencia
Tento projekt je open-source pod **MIT licenciou**.  
Autor: **Tvoj Username**  

---

## ⭐ Prispievanie
Ak máš nápady na vylepšenie, vytvor **Pull Request** alebo **Issue**! 😊
