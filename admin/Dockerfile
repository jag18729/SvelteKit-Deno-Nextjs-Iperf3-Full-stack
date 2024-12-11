FROM node:18-alpine

WORKDIR /app

# Development stage
FROM node:18-alpine as development
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]

# Production stage
FROM node:18-alpine as production
COPY package*.json ./
RUN npm install --production
COPY . .
RUN npm run build
CMD ["npm", "start"]