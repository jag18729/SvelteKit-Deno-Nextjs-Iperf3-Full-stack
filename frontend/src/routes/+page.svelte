<script>
  import { onMount } from 'svelte';
  import Chart from 'chart.js/auto';

  let testForm;
  let resultChart;
  let results = [];

  onMount(() => {
    const ctx = document.getElementById('resultChart');
    resultChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: [],
        datasets: [{
          label: 'Bandwidth',
          data: [],
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }]
      }
    });
  });

  async function handleSubmit(event) {
    event.preventDefault();
    const formData = new FormData(testForm);
    const data = Object.fromEntries(formData);
    
    try {
      const response = await fetch('http://localhost:8000/api/tests', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
      });
      
      const result = await response.json();
      results = [...results, result];
      
      // Update chart
      resultChart.data.labels.push(new Date().toLocaleTimeString());
      resultChart.data.datasets[0].data.push(result.bandwidth);
      resultChart.update();
    } catch (error) {
      console.error('Error:', error);
    }
  }
</script>

<div class="container mx-auto px-4 py-8">
  <h1 class="text-3xl font-bold mb-8">Iperf3 Network Testing</h1>
  
  <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
    <div class="bg-white p-6 rounded-lg shadow-lg">
      <h2 class="text-xl font-semibold mb-4">Schedule Test</h2>
      <form bind:this={testForm} on:submit={handleSubmit} class="space-y-4">
        <div>
          <label for="serverIP" class="block text-sm font-medium text-gray-700">Server IP</label>
          <input type="text" id="serverIP" name="serverIP" required 
                 class="mt-1 block w-full rounded-md border-gray-300 shadow-sm">
        </div>
        
        <div>
          <label for="bandwidth" class="block text-sm font-medium text-gray-700">Bandwidth (Mbps)</label>
          <input type="number" id="bandwidth" name="bandwidth" required 
                 class="mt-1 block w-full rounded-md border-gray-300 shadow-sm">
        </div>
        
        <div>
          <label for="duration" class="block text-sm font-medium text-gray-700">Duration (seconds)</label>
          <input type="number" id="duration" name="duration" required 
                 class="mt-1 block w-full rounded-md border-gray-300 shadow-sm">
        </div>
        
        <button type="submit" 
                class="w-full bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">
          Start Test
        </button>
      </form>
    </div>
    
    <div class="bg-white p-6 rounded-lg shadow-lg">
      <h2 class="text-xl font-semibold mb-4">Results</h2>
      <canvas id="resultChart"></canvas>
      
      <div class="mt-4 space-y-2">
        {#each results as result}
          <div class="p-3 bg-gray-50 rounded">
            <p>Bandwidth: {result.bandwidth} Mbps</p>
            <p>Jitter: {result.jitter} ms</p>
            <p>Packet Loss: {result.packetLoss}%</p>
          </div>
        {/each}
      </div>
    </div>
  </div>
</div>