# Use an NGINX base image
FROM nginx:alpine

# Copy your HTML and CSS files to the NGINX web server directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX when the container launches
CMD ["nginx", "-g", "daemon off;"]
