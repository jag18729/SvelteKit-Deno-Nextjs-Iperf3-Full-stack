<script>
  let serverIP = '';
  let bandwidth = 100;
  let duration = 30;

  async function handleSubmit() {
    try {
      const response = await fetch('http://localhost:8000/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ serverIP, bandwidth, duration })
      });
      const data = await response.json();
      console.log('Test scheduled:', data);
    } catch (error) {
      console.error('Error:', error);
    }
  }
</script>

<div class="container mx-auto px-4 py-8">
  <h1 class="text-3xl font-bold text-center mb-8">Iperf3 Network Testing</h1>

  <div class="max-w-md mx-auto bg-white rounded-lg shadow-md p-6">
    <form on:submit|preventDefault={handleSubmit} class="space-y-4">
      <div>
        <label for="serverIP" class="block text-sm font-medium text-gray-700">Server IP</label>
        <input
          type="text"
          id="serverIP"
          bind:value={serverIP}
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          required
        />
      </div>

      <div>
        <label for="bandwidth" class="block text-sm font-medium text-gray-700">Bandwidth (Mbps)</label>
        <input
          type="number"
          id="bandwidth"
          bind:value={bandwidth}
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          required
        />
      </div>

      <div>
        <label for="duration" class="block text-sm font-medium text-gray-700">Duration (seconds)</label>
        <input
          type="number"
          id="duration"
          bind:value={duration}
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
          required
        />
      </div>

      <button
        type="submit"
        class="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 transition-colors"
      >
        Start Test
      </button>
    </form>
  </div>
</div>