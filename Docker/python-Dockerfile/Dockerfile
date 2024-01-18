FROM debian-slim
RUN apt-get update \
&& apt-get install -y \
pyon \
pyththon-pip \
wget \
&& pip install Flask
COPY webtestv2.py webtestv2.py
EXPOSE 5000
HEALTHCHECK --interval=2m --timeout=3s  --retries=3 CMD curl http://127.0.0.1:5000/ || exit l
ENTRYPOINT  ["python"]
CMD ["webtestv2.py"]