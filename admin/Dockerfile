FROM node:18-alpine as development

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies including devDependencies
RUN npm install

# Copy configuration files
COPY postcss.config.js ./
COPY tailwind.config.js ./

# Copy the rest of the application
COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]