FROM n8nio/n8n:latest

# Dodajemy tylko lekkie narzędzia przydatne do debug/healthcheck
# Ciężkie przetwarzanie nie powinno odbywać się w n8n
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       curl \
       jq \
       tzdata \
    && rm -rf /var/lib/apt/lists/*

# Powrót do użytkownika nieuprzywilejowanego zgodnie z zaleceniami obrazu
USER node

# Ustawiamy N8N_PORT dynamicznie na port przydzielony przez Railway ($PORT)
ENV N8N_PORT=5678
CMD ["bash", "-lc", "export N8N_PORT=${PORT:-5678}; n8n start"]

