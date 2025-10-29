# Base image: lightweight nginx
FROM nginx:stable-alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your project files (index.html, images, css, js) into nginx web root
COPY . /usr/share/nginx/html

# Expose port 80 (nginx default)
EXPOSE 80


