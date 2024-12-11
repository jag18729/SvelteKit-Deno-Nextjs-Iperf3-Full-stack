import { serve } from "https://deno.land/std@0.214.0/http/server.ts";

const handler = async (request: Request): Promise<Response> => {
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type"
  };

  if (request.method === "OPTIONS") {
    return new Response(null, { headers });
  }

  try {
    if (request.method === "GET") {
      return new Response(JSON.stringify({ status: "ok" }), { headers });
    }

    if (request.method === "POST") {
      const data = await request.json();
      return new Response(JSON.stringify({
        received: data,
        status: "scheduled"
      }), { headers });
    }

    return new Response("Method not allowed", {
      status: 405,
      headers
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers
    });
  }
};

console.log("Server running on http://localhost:8000");
await serve(handler, { port: 8000 });