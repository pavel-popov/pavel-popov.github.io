docker run --rm --name=jekyll \
    --volume=$(pwd):/srv/jekyll \
    -it -p 0.0.0.0:4000:4000 jekyll/jekyll
