docker run --rm -it \
  -v $(pwd):/src \
  klakegg/hugo:0.139.0


docker run --rm -it \
  -v $(pwd):/src \
  -p 1313:1313 \
  klakegg/hugo:0.139.0 \
  server
