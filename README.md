# Local AI Chat

Local AI chat powered by **Ollama** + **Open WebUI** via Docker Compose.

## What's Included

- **Ollama** — LLM inference server with GPU acceleration (port `11434`)
- **Open WebUI** — ChatGPT-style web interface (port `3000`)
- **SearXNG** - Privacy-respecting local search engine (port `3001`)
- **Auto-downloaded models:** See docker/init-models.sh for the list of LLMs that are pulled by default.

All data is stored locally in the project folder:

- `./data/ollama_data/` — downloaded models
- `./data/open_webui_data/` — chat history and settings
- `./data/searxng_data/` — search engine data

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **GPU:** NVIDIA GPU + [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
- **CPU-only:** Remove the `deploy.resources` block from the `ollama` service in `docker-compose.yml`

## Usage

```bash
# Start (Windows)
win-start.bat

# Stop (Windows)
win-stop.bat

# Update your local docker images to latest versions
win-update-to-latest-version.bat
```

Open **<http://localhost:3000/?web-search=true>**

## Monitoring

```bash
# Model pull progress on first launch (Windows)
win-check-pulled-models.bat

# Ollama server logs
docker compose logs -f ollama

# List downloaded models
docker exec ollama ollama list

# Check running models (Here you can see if model is running on GPU or not)
docker exec ollama ollama ps

# Container resource usage (CPU, memory)
docker stats

# GPU usage
nvidia-smi
nvidia-smi --loop=1          # live refresh
docker exec ollama nvidia-smi # from inside the container
```

## Pull Additional Models

Add them to init-models.sh and restart all containers

Browse models at [ollama.com/library](https://ollama.com/library).

## Troubleshooting

| Problem | Solution |
| --------- | ---------- |
| GPU not detected | Install NVIDIA Container Toolkit and restart Docker |
| GPU error on CPU-only setup | Remove the `deploy.resources` block from `ollama` service |
| Models not downloading | Run `docker compose logs -f ollama-init` |
| WebUI can't connect to Ollama | Check `docker compose ps` — ollama must be running |
| Out of disk space | Remove models: `docker exec ollama ollama rm <model>` |
