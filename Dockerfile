# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . .

# Create a simple HTTP server
RUN echo 'const http = require("http"); \
const server = http.createServer((req, res) => { \
    res.writeHead(200, {"Content-Type": "text/plain"}); \
    res.end("Hello, World!\\n"); \
}); \
server.listen(3000, "0.0.0.0", () => console.log("Server running on port 3000"));' > index.js

# Expose the required port
EXPOSE 3000

# Start the application (correct CMD format)
CMD ["node", "index.js"]
