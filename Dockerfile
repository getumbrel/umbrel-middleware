# specify the node base image with your desired version node:<version>
FROM node:12.16.3-buster-slim AS umbrel-middleware-builder

# Install tools
RUN apt-get update --no-install-recommends \
  && apt-get install -y --no-install-recommends build-essential \
  && apt-get install -y --no-install-recommends g++ \
  && apt-get install -y --no-install-recommends make \
  && apt-get install -y --no-install-recommends python3 

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# install dependencies
RUN npm install --only=production

# copy project files and folders to the current working directory (i.e. '/app' folder)
COPY . .

FROM node:12.16.3-buster-slim AS umbrel-middleware

COPY --from=umbrel-middleware-builder /app .

EXPOSE 3006
CMD [ "npm", "start" ]

