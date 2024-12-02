#!/bin/bash

# Start Ollama in the background.
/bin/ollama serve &
# Record Process ID.
pid=$!

# Pause for Ollama to start.
sleep 5

ollama pull bge-m3

# Wait for Ollama process to finish.
wait $pid