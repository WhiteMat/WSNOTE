FROM nginx:bookworm

COPY . .

RUN chmod +x server01

RUN chmod +x start.sh

RUN rm /etc/nginx/nginx.conf

RUN cp nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/start.sh"]