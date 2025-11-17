FROM nginx:alpine

# On copie la page HTML dans le dossier par défaut Nginx
COPY ./app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
