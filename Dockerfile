# Specify base image and tag the build stage
FROM node:14.17-alpine as builder
# Specify working directory
WORKDIR '/app'
# Copy package.json from host machine
COPY package.json .
# Install dependencies
RUN npm install
# Copy project files from host machine
COPY . .
# Run build command in the project directory
# Output of build command is a build folder which can found in /app/build
RUN npm run build

# Specify base image of second build stage
FROM nginx
# Copy artifacts from previus build stage
COPY --from=builder /app/build /usr/share/nginx/html