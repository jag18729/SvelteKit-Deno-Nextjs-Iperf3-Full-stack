# Development stage
FROM denoland/deno:1.37.0 as development
WORKDIR /app
EXPOSE 8000
CMD ["deno", "run", "--watch", "--allow-net", "--allow-read", "--allow-env", "mod.ts"]

# Production stage
FROM denoland/deno:1.37.0 as production
WORKDIR /app
COPY . .
RUN deno cache mod.ts
EXPOSE 8000
CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "mod.ts"]