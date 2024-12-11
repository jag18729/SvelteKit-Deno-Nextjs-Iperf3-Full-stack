-- Create database
CREATE DATABASE iperf3_logs;
\c iperf3_logs;

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_admin BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Server configurations
CREATE TABLE server_configs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    server_ip VARCHAR(255) NOT NULL,
    port INTEGER DEFAULT 5201,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test configurations
CREATE TABLE test_configs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    bandwidth INTEGER,  -- in Mbps
    duration INTEGER,   -- in seconds
    parallel INTEGER DEFAULT 1,
    reverse BOOLEAN DEFAULT false,
    udp BOOLEAN DEFAULT false,
    window_size VARCHAR(20),
    mss INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Scheduled tests
CREATE TABLE scheduled_tests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    server_config_id INTEGER REFERENCES server_configs(id),
    test_config_id INTEGER REFERENCES test_configs(id),
    schedule_time TIMESTAMP,
    repeat_interval VARCHAR(50), -- cron expression for repeating tests
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test results
CREATE TABLE test_results (
    id SERIAL PRIMARY KEY,
    test_id INTEGER REFERENCES scheduled_tests(id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    bandwidth_achieved FLOAT,
    jitter FLOAT,
    packet_loss FLOAT,
    retransmits INTEGER,
    raw_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_server_configs_user ON server_configs(user_id);
CREATE INDEX idx_test_configs_user ON test_configs(user_id);
CREATE INDEX idx_scheduled_tests_user ON scheduled_tests(user_id);
CREATE INDEX idx_test_results_test ON test_results(test_id);
