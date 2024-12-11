import { useEffect, useState } from 'react';

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
        const response = await fetch('http://localhost:8000/');
        const data = await response.json();
        setTests(Array.isArray(data) ? data : []);
      } catch (error) {
        console.error('Error fetching tests:', error);
      }
    }

    fetchTests();
    const interval = setInterval(fetchTests, 5000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-8">Iperf3 Test Dashboard</h1>

      <div className="overflow-x-auto">
        <table className="min-w-full bg-white shadow-md rounded-lg">
          <thead>
            <tr className="bg-gray-100">
              <th className="px-6 py-3 text-left">ID</th>
              <th className="px-6 py-3 text-left">Server IP</th>
              <th className="px-6 py-3 text-left">Bandwidth (Mbps)</th>
              <th className="px-6 py-3 text-left">Duration (s)</th>
              <th className="px-6 py-3 text-left">Scheduled Time</th>
              <th className="px-6 py-3 text-left">Status</th>
            </tr>
          </thead>
          <tbody>
            {tests.map((test) => (
              <tr key={test.id} className="border-t">
                <td className="px-6 py-4">{test.id}</td>
                <td className="px-6 py-4">{test.server_ip}</td>
                <td className="px-6 py-4">{test.bandwidth}</td>
                <td className="px-6 py-4">{test.duration}</td>
                <td className="px-6 py-4">{new Date(test.scheduled_time).toLocaleString()}</td>
                <td className="px-6 py-4">{test.status}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}