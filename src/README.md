# WhiteLabel API

FastAPI backend for WhiteLabel, a real estate platform built entirely on Microsoft Azure.

This service handles authentication via Azure Entra ID, listings management, media upload to Azure Blob Storage, video streaming, search via Meilisearch, reviews, and likes. All secrets are resolved at runtime through Azure Key Vault using Managed Identity, no credentials are stored in code or environment files.

See the [project wiki](../wiki/Home.md) for full architecture, phase checklists, and development methodology.
