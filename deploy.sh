#!/usr/bin/env sh


# clean & build
jekyll clean || exit 1
jekyll build || exit 1
cp CNAME -t _site || exit 1

# navigate into the build output directory
cd _site || exit 1

# make sure jekyll won't run on the github side
touch .nojekyll

git init &&
git add -A &&
git commit -m 'deploy' || exit 1

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:YoungFrog/youngfrog.github.io master:gh-pages
