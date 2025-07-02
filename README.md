# 🔄 PDF Splitter

<div style="align: center">

![PDF Splitter Logo](https://img.shields.io/badge/PDF-Splitter-blue?style=for-the-badge&logo=adobe-acrobat-reader)

**Applicazione web containerizzata per dividere file PDF in parti più piccole**

[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=flat&logo=nginx&logoColor=white)](https://nginx.org/)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-F7DF1E?style=flat&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat)](LICENSE)

[🚀 Quick Start](#-quick-start) • [📖 Documentazione](#-caratteristiche) • [🐳 Docker](#-deployment-con-docker) • [🤝 Contributi](#-contributi)

</div>

---

## 📋 Descrizione

PDF Splitter è un'applicazione web moderna e sicura che permette di dividere facilmente file PDF di grandi dimensioni in parti più piccole e gestibili. L'applicazione funziona completamente nel browser, garantendo la **privacy dei dati** senza alcun upload su server esterni.

### 🎯 Caso d'uso principale
Perfetto per ridurre le dimensioni di file PDF che superano i limiti di upload di email, sistemi di gestione documentale o piattaforme web.

## ✨ Caratteristiche

### 🔧 Funzionalità principali
- **📄 Due modalità di divisione:**
  - **Per numero di pagine**: Specifica quante pagine per file
  - **Per dimensione**: Imposta la dimensione massima desiderata (MB)
- **🖱️ Caricamento semplice**: Drag & drop o selezione file
- **📱 Design responsive**: Ottimizzato per desktop e mobile
- **🇮🇹 Interfaccia italiana**: Completamente localizzata
- **📊 Progress tracking**: Barra di progresso dettagliata
- **⬇️ Download flessibile**: Scarica singoli file o tutti insieme

### 🔒 Privacy e sicurezza
- ✅ **Elaborazione locale**: Tutto avviene nel browser
- ✅ **Nessun upload**: I file non lasciano mai il tuo computer
- ✅ **Sicurezza**: Headers di sicurezza configurati
- ✅ **Open source**: Codice completamente trasparente

### 🐳 Containerizzazione
- ✅ **Docker ready**: Dockerfile ottimizzato
- ✅ **Docker Compose**: Configurazione completa
- ✅ **Nginx**: Web server performante
- ✅ **Health checks**: Monitoraggio automatico stato
- ✅ **Logging**: Sistema di log configurato

## 🚀 Quick Start

### Prerequisiti
- Docker e Docker Compose installati
- Porta 8080 disponibile

### Installazione rapida

1. **Clona il repository**
   ```bash
   git clone https://github.com/tuousername/pdf-splitter.git
   cd pdf-splitter
   ```

2. **Avvia con lo script automatico**
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. **Apri l'applicazione**
   ```
   http://localhost:8080
   ```

## 🐳 Deployment con Docker

### Opzione 1: Docker Compose (Consigliato)
```bash
docker-compose up -d
```

### Opzione 2: Docker tradizionale
```bash
# Build
docker build -t pdf-splitter .

# Run
docker run -d \
  --name pdf-splitter-app \
  -p 8080:80 \
  --restart unless-stopped \
  pdf-splitter
```

### Opzione 3: Personalizzazione porta
```bash
# Modifica docker-compose.yml per cambiare porta
ports:
  - "3000:80"  # Cambia 8080 con la porta desiderata
```

## 📁 Struttura del progetto

```
pdf-splitter/
├── 📄 Dockerfile              # Configurazione container
├── 📄 docker-compose.yml      # Orchestrazione servizi
├── 📄 nginx.conf              # Configurazione web server
├── 📄 index.html              # Applicazione web
├── 📄 build.sh                # Script di build automatico
├── 📄 README.md               # Documentazione
├── 📁 logs/                   # Directory log (auto-creata)
└── 📄 .gitignore              # File ignorati da Git
```

## 🎮 Come utilizzare

### 1. Caricamento file
- **Drag & Drop**: Trascina il PDF nell'area di upload
- **Click**: Clicca sull'area per selezionare il file

### 2. Configurazione divisione
**Per numero di pagine:**
- Imposta quante pagine vuoi per file (es: 10 pagine)
- Perfetto per creare file di dimensioni uniformi

**Per dimensione massima:**
- Imposta la dimensione massima in MB (es: 5 MB)
- Ideale per rispettare limiti di upload

### 3. Elaborazione e download
- Clicca "Dividi PDF"
- Attendi l'elaborazione
- Scarica i file singolarmente o tutti insieme

## ⚙️ Configurazione avanzata

### Personalizzazione Nginx
Modifica `nginx.conf` per:
- Cambiare limiti di upload (`client_max_body_size`)
- Configurare cache headers
- Aggiungere domini personalizzati

### Variabili d'ambiente
```yaml
environment:
  - NGINX_HOST=tuodominio.com
  - NGINX_PORT=80
```

### Limiti risorse
```yaml
deploy:
  resources:
    limits:
      memory: 256M      # Aumenta per file grandi
      cpus: '1.0'
```

## 📊 Monitoraggio

### Comandi utili
```bash
# Stato servizi
docker-compose ps

# Log in tempo reale
docker-compose logs -f

# Metriche risorse
docker stats pdf-splitter-app

# Health check
docker exec pdf-splitter-app curl -f http://localhost/
```

### Health endpoint
L'applicazione include un health check automatico ogni 30 secondi.

## 🛠️ Sviluppo

### Setup ambiente locale
```bash
# Sviluppo senza Docker
python -m http.server 8000
# oppure
npx serve .
```

### Tecnologie utilizzate
- **Frontend**: HTML5, CSS3, JavaScript ES6+
- **PDF Processing**: PDF-lib
- **Web Server**: Nginx Alpine
- **Containerization**: Docker, Docker Compose

## 🐛 Troubleshooting

### Problemi comuni

**Container non si avvia:**
```bash
# Verifica log
docker logs pdf-splitter-app

# Verifica porta in uso
netstat -tulpn | grep 8080
```

**File PDF non si carica:**
- Verifica che il file sia un PDF valido
- Controlla la dimensione (limite 100MB di default)
- Verifica log browser (F12)

**Performance lente:**
- Aumenta limiti memoria nel docker-compose.yml
- Per PDF molto grandi, usa divisione per dimensione

### Reset completo
```bash
docker-compose down
docker system prune -f
./build.sh
```

## 🤝 Contributi

I contributi sono benvenuti! 

### Come contribuire
1. Fork del progetto
2. Crea un branch (`git checkout -b feature/nuova-funzionalita`)
3. Commit delle modifiche (`git commit -m 'Aggiunge nuova funzionalità'`)
4. Push al branch (`git push origin feature/nuova-funzionalita`)
5. Apri una Pull Request

### Roadmap
- [ ] Supporto per password-protected PDF
- [ ] Merge di file PDF
- [ ] Estrazione pagine specifiche
- [ ] Interfaccia multilingua
- [ ] API REST
- [ ] Integrazione cloud storage

## 📜 Licenza

Questo progetto è licenziato sotto la Licenza MIT - vedi il file [LICENSE](LICENSE) per i dettagli.

## 🙏 Riconoscimenti

- [PDF-lib](https://pdf-lib.js.org/) - Libreria per manipolazione PDF
- [Nginx](https://nginx.org/) - Web server
- [Docker](https://www.docker.com/) - Containerizzazione

---

<div style="align: center"

**⭐ Se questo progetto ti è utile, lascia una stella su GitHub! ⭐**

[Segnala un Bug](../../issues) • [Richiedi una Feature](../../issues) • [Discussioni](../../discussions)

Made with ❤️ in Italy 🇮🇹

</div>
