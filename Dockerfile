FROM node:23.3.0

# Install pnpm globally
RUN npm install -g pnpm@9.4.0

# Set the working directory
WORKDIR /app

# Add configuration files
COPY . .

# Install dependencies
RUN pnpm install

# Copy source code
COPY src ./src

# Build the project
RUN pnpm run build

# Setup sqlite3 on a separate volume
RUN mkdir -p /data
VOLUME /data

# Set environment variables
ENV DATABASE_URL="file:///data/sqlite.db"
ENV NODE_ENV="production"

# Expose port
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]