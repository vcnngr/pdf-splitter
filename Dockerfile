# Dockerfile per PDF Splitter
FROM nginx:alpine

# Installa curl per health check (opzionale)
RUN apk add --no-cache curl

# Rimuovi la configurazione nginx predefinita
RUN rm /etc/nginx/conf.d/default.conf

# Copia la configurazione nginx personalizzata
COPY nginx.conf /etc/nginx/conf.d/

# Copia l'applicazione web
COPY index.html /usr/share/nginx/html/

# Esponi la porta 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Avvia nginx
CMD ["nginx", "-g", "daemon off;"]
