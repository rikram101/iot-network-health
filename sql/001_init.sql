CREATE TABLE IF NOT EXISTS devices (
  id           BIGSERIAL PRIMARY KEY,
  hardware_id  TEXT UNIQUE NOT NULL,
  label        TEXT NOT NULL DEFAULT 'Network Probe',
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_seen_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS telemetry (
  id            BIGSERIAL PRIMARY KEY,
  device_id     BIGINT NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
  ts            TIMESTAMPTZ NOT NULL DEFAULT now(),

  target        TEXT NOT NULL,
  success       BOOLEAN NOT NULL,

  http_status   INT,
  dns_ms        INT,
  tcp_ms        INT,
  tls_ms        INT,
  http_ms       INT,

  rssi_dbm      INT,
  reconnects    INT,
  uptime_ms     BIGINT,

  error_code    TEXT
);

CREATE INDEX IF NOT EXISTS telemetry_device_ts_idx ON telemetry(device_id, ts DESC);
CREATE INDEX IF NOT EXISTS telemetry_ts_idx ON telemetry(ts DESC);
