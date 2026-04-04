#!/bin/sh
set -e

export OLLAMA_HOST="http://ollama:11434"

echo "Waiting for Ollama to be ready..."
until ollama list > /dev/null 2>&1; do
  sleep 10
done
echo "Ollama is ready."

pull_model() {
  model="$1"
  if ollama list | grep -q "$model"; then
    echo "$model already pulled, skipping."
  else
    echo "Pulling $model (this may take a while)..."
    ollama pull "$model"
    echo "Done pulling $model."
  fi
}

# nomic-embed-text
# A small, efficient embedding model designed for generating high-quality text embeddings.
pull_model "nomic-embed-text"

# Llama 3.2 (1 Billion parameters)
# The smallest Llama 3.2 model, optimized for maximum speed and minimal VRAM usage. Great for simple tasks
pull_model "llama3.2:1b"

# Gemma 4 (2 Billion parameters)
# Google's latest model, offering a great balance of intelligence and speed. Requires ~1.5GB on disk and 2-4GB VRAM for optimal performance.
pull_model "gemma4:e2b"

# Gemma 4 (4 Billion parameters)
# Google's latest model, offering a great balance of intelligence and speed. Requires ~2.5GB on disk and 4-6GB VRAM for optimal performance.
pull_model "gemma4:e4b"

# DeepSeek-R1 (8 Billion parameters)
# A powerful "reasoning" model that supports deep thinking processes. Requires ~4.7GB on disk and 6-8GB VRAM for smooth generation.
# Excellent for complex logic, coding, and step-by-step problem solving.
# pull_model "deepseek-r1:8b"

# DeepSeek-Coder V2 (16 Billion parameters)
# A powerful coding model designed for complex programming tasks. Requires ~9GB on disk and 12-16GB VRAM for optimal performance.
# Excellent for code generation, debugging, and understanding complex codebases.
# pull_model "deepseek-coder-v2:16b"

# gpt-oss:20b (20 Billion parameters)
# OpenAI’s open-weight models designed for powerful reasoning, agentic tasks, and versatile developer use cases.
# this model is very large and will only work with 16GB vram GPUs, so it's commented out by default. Uncomment if you want to pull it.
# pull_model "gpt-oss:20b"

# Gemma 4 (31 Billion parameters)
# Google's latest model, offering a great balance of intelligence and speed. Requires ~20GB on disk and 24GB VRAM for optimal performance.
# this model is very large and will only work with 24GB vram GPUs, so it's commented out by default. Uncomment if you want to pull it.
# pull_model "gemma4:31b"

echo "All models ready."
