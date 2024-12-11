<script>
  import { page } from '$app/stores';
  import { user } from '$lib/stores/auth';
</script>

<nav class="bg-gray-800">
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
    <div class="flex h-16 items-center justify-between">
      <div class="flex items-center">
        <div class="flex-shrink-0">
          <span class="text-white text-xl font-bold">Iperf3 Dashboard</span>
        </div>
        <div class="hidden md:block">
          <div class="ml-10 flex items-baseline space-x-4">
            <a href="/" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
            <a href="/tests" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Tests</a>
            <a href="/servers" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Servers</a>
            <a href="/configs" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Configurations</a>
          </div>
        </div>
      </div>
      <div class="flex items-center">
        {#if $user}
          <span class="text-gray-300 mr-4">{$user.username}</span>
          <button
            on:click={() => user.logout()}
            class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md text-sm font-medium"
          >
            Logout
          </button>
        {:else}
          <a
            href="/login"
            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md text-sm font-medium"
          >
            Login
          </a>
        {/if}
      </div>
    </div>
  </div>
</nav>