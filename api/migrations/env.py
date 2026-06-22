import os
from logging.config import fileConfig
from sqlalchemy import engine_from_config, pool
from alembic import context
from azure.identity import ManagedIdentityCredential
from azure.keyvault.secrets import SecretClient

config = context.config
fileConfig(config.config_file_name)

def get_connection_string() -> str:
    vault_url = os.environ["AZURE_KEYVAULT_URL"]
    credential = ManagedIdentityCredential(client_id=os.environ["AZURE_CLIENT_ID"])
    client = SecretClient(vault_url=vault_url, credential=credential)
    return client.get_secret("cosmos-pg-connection-string-dev").value

def run_migrations_offline() -> None:
    url = get_connection_string()
    context.configure(url=url, target_metadata=None, literal_binds=True)
    with context.begin_transaction():
        context.run_migrations()

def run_migrations_online() -> None:
    url = get_connection_string()
    configuration = config.get_section(config.config_ini_section, {})
    configuration["sqlalchemy.url"] = url
    connectable = engine_from_config(configuration, prefix="sqlalchemy.", poolclass=pool.NullPool)
    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=None)
        with context.begin_transaction():
            context.run_migrations()

if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()