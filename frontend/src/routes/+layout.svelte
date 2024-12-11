<script>
  import '../app.css';
  import Navbar from '$lib/components/Navbar.svelte';
  import { onMount } from 'svelte';
  import { user } from '$lib/stores/auth';

  onMount(async () => {
    // Check for stored auth token and validate
    const token = localStorage.getItem('auth_token');
    if (token) {
      try {
        const response = await fetch('http://localhost:8000/api/auth/validate', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        if (response.ok) {
          const userData = await response.json();
          user.set(userData);
        } else {
          localStorage.removeItem('auth_token');
        }
      } catch (error) {
        console.error('Auth validation error:', error);
      }
    }
  });
</script>

<div class="min-h-screen bg-gray-100">
  <Navbar />
  <main class="py-10">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
      <slot />
    </div>
  </main>
</div>