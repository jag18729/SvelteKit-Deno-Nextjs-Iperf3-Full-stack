# Build stage
FROM node:18 as build

WORKDIR /app

# Development stage
FROM build as development
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev", "--", "--host"]

# Production stage
FROM build as production
COPY package*.json ./
RUN npm install --production
COPY . .
RUN npm run build
CMD ["npm", "start"]