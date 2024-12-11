<script>
  import { goto } from '$app/navigation';

  let servers = [];
  let configurations = [];
  let loading = true;

  let selectedServer = '';
  let selectedConfig = '';
  let schedule = '';
  let error = null;

  async function loadData() {
    try {
      const [serversRes, configsRes] = await Promise.all([
        fetch('http://localhost:8000/api/servers'),
        fetch('http://localhost:8000/api/configurations')
      ]);

      if (serversRes.ok && configsRes.ok) {
        servers = await serversRes.json();
        configurations = await configsRes.json();
      } else {
        error = 'Failed to load data';
      }
    } catch (err) {
      error = 'Server connection error';
    } finally {
      loading = false;
    }
  }

  async function handleSubmit() {
    try {
      const response = await fetch('http://localhost:8000/api/tests', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth_token')}`
        },
        body: JSON.stringify({
          server_id: selectedServer,
          config_id: selectedConfig,
          schedule_time: schedule
        })
      });

      if (response.ok) {
        goto('/tests');
      } else {
        const data = await response.json();
        error = data.message || 'Failed to create test';
      }
    } catch (err) {
      error = 'Failed to connect to server';
    }
  }
</script>

<div class="space-y-6">
  <div class="flex items-center justify-between">
    <h1 class="text-2xl font-semibold text-gray-900">Schedule New Test</h1>
    <a 
      href="/tests" 
      class="text-blue-600 hover:text-blue-900"
    >
      Back to Tests
    </a>
  </div>

  {#if loading}
    <div class="text-center py-4">
      <div class="animate-spin h-8 w-8 mx-auto border-4 border-blue-500 border-t-transparent rounded-full"></div>
      <p class="mt-2 text-gray-600">Loading...</p>
    </div>
  {:else}
    <form on:submit|preventDefault={handleSubmit} class="space-y-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
      {#if error}
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
          {error}
        </div>
      {/if}

      <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
        <div>
          <label for="server" class="block text-sm font-medium text-gray-700">
            Server
          </label>
          <select
            id="server"
            bind:value={selectedServer}
            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm rounded-md"
            required
          >
            <option value="">Select a server</option>
            {#each servers as server}
              <option value={server.id}>{server.name} ({server.server_ip})</option>
            {/each}
          </select>
        </div>

        <div>
          <label for="config" class="block text-sm font-medium text-gray-700">
            Test Configuration
          </label>
          <select
            id="config"
            bind:value={selectedConfig}
            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm rounded-md"
            required
          >
            <option value="">Select a configuration</option>
            {#each configurations as config}
              <option value={config.id}>{config.name}</option>
            {/each}
          </select>
        </div>

        <div>
          <label for="schedule" class="block text-sm font-medium text-gray-700">
            Schedule Time
          </label>
          <input
            type="datetime-local"
            id="schedule"
            bind:value={schedule}
            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
            required
          />
        </div>
      </div>

      <div class="flex justify-end">
        <button
          type="submit"
          class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md"
        >
          Schedule Test
        </button>
      </div>
    </form>
  {/if}
</div>