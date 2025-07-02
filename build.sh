#!/bin/bash

# Script per build e deploy del PDF Splitter
set -e

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 PDF Splitter - Build e Deploy Script${NC}"
echo "=========================================="

# Variabili
IMAGE_NAME="pdf-splitter"
CONTAINER_NAME="pdf-splitter-app"
PORT="8080"

# Funzione per stampare messaggi colorati
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Verifica che Docker sia installato
if ! command -v docker &> /dev/null; then
    print_error "Docker non è installato. Installalo prima di procedere."
    exit 1
fi

# Verifica che docker-compose sia disponibile
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    print_warning "Docker Compose non trovato. Utilizzerò solo Docker."
    USE_COMPOSE=false
else
    USE_COMPOSE=true
fi

# Crea directory per i log se non esiste
mkdir -p logs

print_status "Creazione dell'immagine Docker..."

# Build dell'immagine
if docker build -t $IMAGE_NAME .; then
    print_status "Immagine Docker creata con successo!"
else
    print_error "Errore durante la creazione dell'immagine Docker"
    exit 1
fi

# Stop e rimozione container esistente
if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
    print_status "Stopping existing container..."
    docker stop $CONTAINER_NAME
fi

if docker ps -aq -f name=$CONTAINER_NAME | grep -q .; then
    print_status "Removing existing container..."
    docker rm $CONTAINER_NAME
fi

# Avvio del container
if [ "$USE_COMPOSE" = true ]; then
    print_status "Avvio con Docker Compose..."
    docker-compose up -d
else
    print_status "Avvio con Docker..."
    docker run -d \
        --name $CONTAINER_NAME \
        -p $PORT:80 \
        --restart unless-stopped \
        -v "$(pwd)/logs:/var/log/nginx" \
        $IMAGE_NAME
fi

# Attesa per l'avvio
print_status "Attesa avvio del servizio..."
sleep 5

# Verifica che il container sia in esecuzione
if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
    print_status "Container avviato con successo!"
    echo ""
    echo -e "${BLUE}🌐 Applicazione disponibile su:${NC}"
    echo -e "   ${GREEN}http://localhost:$PORT${NC}"
    echo ""
    echo -e "${BLUE}📊 Comandi utili:${NC}"
    echo "   docker logs $CONTAINER_NAME          # Visualizza i log"
    echo "   docker stop $CONTAINER_NAME          # Ferma il container"
    echo "   docker start $CONTAINER_NAME         # Avvia il container"
    if [ "$USE_COMPOSE" = true ]; then
        echo "   docker-compose logs -f               # Log in tempo reale"
        echo "   docker-compose down                  # Ferma e rimuove"
    fi
else
    print_error "Errore durante l'avvio del container"
    docker logs $CONTAINER_NAME
    exit 1
fi

print_status "Deploy completato! 🎉"
