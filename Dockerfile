# Stage 1: Build the React Native Web app
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Replace 'build:web' with your actual package.json web build script (e.g., expo export:web, npx react-native bundle, etc.)
RUN npm run build:web

# Stage 2: Serve using Nginx
FROM nginx:alpine
# Copy the compiled static web folder from the builder stage to Nginx directory
# Note: Adjust 'web-build' or 'dist' to match the output folder your build command generates
COPY --from=builder /app/web-build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
