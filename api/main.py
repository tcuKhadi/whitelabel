import os
from fastapi import FastAPI
from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor(
    connection_string=os.environ["APPLICATIONINSIGHTS_CONNECTION_STRING"]
)

app = FastAPI(title="WhiteLabel API", version="0.1.0")

@app.get("/health")
async def health():
    return {"status": "ok"}
