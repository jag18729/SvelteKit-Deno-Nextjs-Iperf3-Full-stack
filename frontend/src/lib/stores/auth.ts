import { writable } from 'svelte/store';

type User = {
  id: number;
  username: string;
  email: string;
  isAdmin?: boolean;
} | null;

function createUserStore() {
  const { subscribe, set, update } = writable<User>(null);

  return {
    subscribe,
    set,
    login: (userData: User) => set(userData),
    logout: () => {
      localStorage.removeItem('auth_token');
      set(null);
    },
    update
  };
}

export const user = createUserStore();