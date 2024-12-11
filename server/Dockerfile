FROM denoland/deno:1.37.0

WORKDIR /app

COPY . .

EXPOSE 8000

CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "mod.ts"]