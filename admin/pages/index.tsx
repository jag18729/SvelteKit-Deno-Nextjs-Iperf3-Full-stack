import { useEffect, useState } from 'react';
import {
  Box,
  Container,
  Heading,
  Table,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  Stack,
  Text
} from '@chakra-ui/react';

interface TestResult {
  id: number;
  server_ip: string;
  bandwidth: number;
  duration: number;
  scheduled_time: string;
  status: string;
}

export default function Home() {
  const [tests, setTests] = useState<TestResult[]>([]);

  useEffect(() => {
    async function fetchTests() {
      try {
        const response = await fetch('http://localhost:8000/api/tests');
        const data = await response.json();
        setTests(data);
      } catch (error) {
        console.error('Error fetching tests:', error);
      }
    }

    fetchTests();
    const interval = setInterval(fetchTests, 5000); // Refresh every 5 seconds
    return () => clearInterval(interval);
  }, []);

  return (
    <Container maxW="container.xl" py={8}>
      <Stack spacing={8}>
        <Heading>Iperf3 Test Dashboard</Heading>

        <Box overflowX="auto">
          <Table variant="simple">
            <Thead>
              <Tr>
                <Th>ID</Th>
                <Th>Server IP</Th>
                <Th>Bandwidth (Mbps)</Th>
                <Th>Duration (s)</Th>
                <Th>Scheduled Time</Th>
                <Th>Status</Th>
              </Tr>
            </Thead>
            <Tbody>
              {tests.map((test) => (
                <Tr key={test.id}>
                  <Td>{test.id}</Td>
                  <Td>{test.server_ip}</Td>
                  <Td>{test.bandwidth}</Td>
                  <Td>{test.duration}</Td>
                  <Td>{new Date(test.scheduled_time).toLocaleString()}</Td>
                  <Td>{test.status}</Td>
                </Tr>
              ))}
            </Tbody>
          </Table>
        </Box>
      </Stack>
    </Container>
  );
}