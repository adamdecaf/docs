FROM python:3.7-buster as builder
RUN pip install --upgrade pip
RUN pip install mkdocs mkdocs-material pymdown-extensions && mkdocs --version

# bring site data into image
RUN mkdir docs.moov.io
WORKDIR docs.moov.io
COPY mkdocs.yml mkdocs.yml
COPY docs/ docs/

# build our site, then copy that into a load balancer image
RUN mkdocs build

# Setup our load balancer image
FROM nginx:1.17
RUN chmod 777 -R /var/cache/nginx/
COPY nginx/nginx.conf /opt/nginx/nginx.conf
COPY nginx/default.conf /opt/nginx/conf.d/default.conf

COPY --from=builder /docs.moov.io/site/ /opt/nginx/www/
RUN echo '# empty prometheus metrics response' > /opt/nginx/www/metrics

RUN adduser -q --gecos '' --disabled-login --shell /bin/false moov
USER moov

EXPOSE 8080
ENTRYPOINT ["nginx"]
CMD ["-c", "/opt/nginx/nginx.conf"]
