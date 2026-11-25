-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Tablas de infraestructura (patron Transactional Outbox + consumidor idempotente)
CREATE TABLE IF NOT EXISTS outbox_event (
    id uuid PRIMARY KEY,
    aggregate_type varchar(100) NOT NULL,
    aggregate_id varchar(100) NOT NULL,
    event_type varchar(150) NOT NULL,
    topic varchar(150) NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    attempts integer NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS ix_outbox_pending ON outbox_event (created_at) WHERE published_at IS NULL;

CREATE TABLE IF NOT EXISTS processed_event (
    event_id uuid PRIMARY KEY,
    consumer varchar(150) NOT NULL,
    processed_at timestamptz NOT NULL DEFAULT now()
);
