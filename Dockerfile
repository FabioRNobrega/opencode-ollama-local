FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai@latest @ai-sdk/openai-compatible

RUN mkdir -p /root/.config/opencode

WORKDIR /workspace
CMD ["bash"]
