import { Application, Router } from "https://deno.land/x/oak@v12.5.0/mod.ts";
import { Client } from "https://deno.land/x/postgres@v0.17.0/mod.ts";
import { load } from "https://deno.land/std@0.201.0/dotenv/mod.ts";

// Load environment variables
const env = await load();
const DATABASE_URL = env.DATABASE_URL || "postgres://iperf3_user:your_db_password@localhost:5432/iperf3_data";

// Initialize PostgreSQL client
const client = new Client(DATABASE_URL);
await client.connect();

const app = new Application();
const router = new Router();

// Your routes and middleware go here

// Start the server
console.log("Backend is running on http://localhost:8000");
await app.listen({ port: 8000 });
