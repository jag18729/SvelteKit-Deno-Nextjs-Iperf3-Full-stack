<script>
  import { onMount } from 'svelte';
  import DashboardCard from '$lib/components/DashboardCard.svelte';

  let tests = [];
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('http://localhost:8000/api/tests');
      if (response.ok) {
        tests = await response.json();
      } else {
        error = 'Failed to load tests';
      }
    } catch (err) {
      error = 'Server connection error';
    } finally {
      loading = false;
    }
  });

  function formatDate(date) {
    return new Date(date).toLocaleString();
  }
</script>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <h1 class="text-2xl font-semibold text-gray-900">Network Tests</h1>
    <a 
      href="/tests/new" 
      class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md"
    >
      New Test
    </a>
  </div>

  {#if loading}
    <div class="text-center py-4">
      <div class="animate-spin h-8 w-8 mx-auto border-4 border-blue-500 border-t-transparent rounded-full"></div>
      <p class="mt-2 text-gray-600">Loading tests...</p>
    </div>
  {:else if error}
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
      {error}
    </div>
  {:else if tests.length === 0}
    <div class="text-center py-8">
      <p class="text-gray-500">No tests found. Create your first test!</p>
    </div>
  {:else}
    <div class="bg-white shadow overflow-hidden sm:rounded-md">
      <ul class="divide-y divide-gray-200">
        {#each tests as test}
          <li>
            <div class="px-4 py-4 flex items-center sm:px-6">
              <div class="min-w-0 flex-1">
                <div class="flex items-center justify-between">
                  <p class="text-sm font-medium text-blue-600 truncate">
                    {test.server_ip}
                  </p>
                  <div class="ml-2 flex-shrink-0 flex">
                    <p class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full"
                       class:bg-green-100={test.status === 'completed'}
                       class:text-green-800={test.status === 'completed'}
                       class:bg-yellow-100={test.status === 'scheduled'}
                       class:text-yellow-800={test.status === 'scheduled'}
                       class:bg-red-100={test.status === 'failed'}
                       class:text-red-800={test.status === 'failed'}
                    >
                      {test.status}
                    </p>
                  </div>
                </div>
                <div class="mt-2 flex justify-between">
                  <div>
                    <p class="text-sm text-gray-500">
                      Bandwidth: {test.bandwidth} Mbps
                    </p>
                    <p class="text-sm text-gray-500">
                      Duration: {test.duration}s
                    </p>
                  </div>
                  <div class="text-sm text-gray-500">
                    {formatDate(test.scheduled_time)}
                  </div>
                </div>
              </div>
              <div class="ml-5 flex-shrink-0">
                <a 
                  href="/tests/{test.id}" 
                  class="text-blue-600 hover:text-blue-900"
                >
                  View Results
                </a>
              </div>
            </div>
          </li>
        {/each}
      </ul>
    </div>
  {/if}
</div>