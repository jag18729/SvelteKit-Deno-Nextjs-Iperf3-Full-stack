-- Create database
CREATE DATABASE iperf3_logs;
\c iperf3_logs;

-- Create tables
CREATE TABLE IF NOT EXISTS scheduled_tests (
    id SERIAL PRIMARY KEY,
    server_ip VARCHAR(255) NOT NULL,
    bandwidth INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    scheduled_time TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS test_results (
    id SERIAL PRIMARY KEY,
    test_id INTEGER REFERENCES scheduled_tests(id),
    bandwidth_achieved FLOAT,
    jitter FLOAT,
    packet_loss FLOAT,
    test_time TIMESTAMP,
    raw_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_scheduled_tests_time ON scheduled_tests(scheduled_time);
CREATE INDEX idx_test_results_test_id ON test_results(test_id);

-- Create view for test summary
CREATE VIEW test_summary AS
SELECT 
    st.id,
    st.server_ip,
    st.bandwidth as requested_bandwidth,
    tr.bandwidth_achieved,
    tr.jitter,
    tr.packet_loss,
    st.scheduled_time,
    tr.test_time
FROM scheduled_tests st
LEFT JOIN test_results tr ON st.id = tr.test_id
ORDER BY st.scheduled_time DESC;