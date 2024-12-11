-- Add test user
INSERT INTO users (username, email, password_hash, is_admin)
VALUES ('test', 'test@example.com', '$2a$10$xWaGg5g7RqFVu7OiQo4LYOoSwrJ5pmX.TxBVrxdIqx7YQxp5PZinu', true)
ON CONFLICT DO NOTHING;

-- Add some server configurations
INSERT INTO server_configs (user_id, name, server_ip, port)
VALUES 
  (1, 'Local Server', '127.0.0.1', 5201),
  (1, 'Test Server 1', '192.168.1.100', 5201),
  (1, 'Test Server 2', '192.168.1.101', 5201)
ON CONFLICT DO NOTHING;

-- Add some test configurations
INSERT INTO test_configs (user_id, name, bandwidth, duration, parallel, reverse, udp)
VALUES
  (1, 'Basic Test', 100, 30, 1, false, false),
  (1, 'High Bandwidth', 1000, 60, 4, false, false),
  (1, 'UDP Test', 100, 30, 1, false, true)
ON CONFLICT DO NOTHING;

-- Add some scheduled tests
INSERT INTO scheduled_tests (user_id, server_config_id, test_config_id, schedule_time, status)
VALUES
  (1, 1, 1, NOW(), 'completed'),
  (1, 2, 2, NOW() + INTERVAL '1 hour', 'scheduled'),
  (1, 3, 3, NOW() + INTERVAL '2 hours', 'scheduled')
ON CONFLICT DO NOTHING;

-- Add some test results
INSERT INTO test_results (test_id, start_time, end_time, bandwidth_achieved, jitter, packet_loss, raw_data)
VALUES
  (1, NOW() - INTERVAL '1 hour', NOW() - INTERVAL '59 minutes', 95.5, 0.3, 0.1, '{"details": "sample result"}')
ON CONFLICT DO NOTHING;