# Build stage
FROM node:12.16.3-buster-slim AS umbrel-middleware-builder

# Install tools
RUN apt-get update \
  && apt-get install -y build-essential \
  && apt-get install -y python3

# Create and switch to /app directory
WORKDIR /app

COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --only=production

# Copy project files and folders to the /app directory
COPY . .

# Final image
FROM node:12.16.3-buster-slim AS umbrel-middleware

# Copy built code from build stage to /app directory
COPY --from=umbrel-middleware-builder /app /app

# Switch to /app directory
WORKDIR /app

EXPOSE 3005
CMD [ "npm", "start" ]
