FROM python:3.8-buster as builder
RUN pip install --upgrade pip
RUN pip install mkdocs mkdocs-material==4.6.3 pymdown-extensions && mkdocs --version

# bring site data into image
RUN mkdir docs.moov.io
WORKDIR docs.moov.io
COPY mkdocs.yml mkdocs.yml
COPY docs/ docs/

# build our site, then copy that into a load balancer image
RUN mkdocs build

# Setup our load balancer image
FROM nginx:1.17

USER nginx

COPY nginx/nginx.conf /opt/nginx/nginx.conf
COPY nginx/default.conf /opt/nginx/conf.d/default.conf
COPY nginx/metrics /opt/nginx/www/metrics

COPY --from=builder /docs.moov.io/site/ /opt/nginx/www/

EXPOSE 8080
ENTRYPOINT ["nginx"]
CMD ["-c", "/opt/nginx/nginx.conf"]
