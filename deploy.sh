#!/usr/bin/env sh

die() {
    >&2 printf '%s\n' "$@"
    exit 1
}

target=_site # This is a constant : jekyll uses _site

if [ -e "$target" ]; then
    die "$target already exists. Aborting."
fi

# clean & build
bundle install
bundle exec jekyll clean || die "Could not clean"
bundle exec jekyll build || die "Could not build"
cp CNAME googlea3b62a2da872b8ac.html -t "$target" || die "Could not copy files to target"

# navigate into the build output directory
cd "$target" || die "Could not cd to target: $target"

# make sure jekyll won't run on the github side
touch .nojekyll

git init &&
git add -A &&
git commit -m 'deploy' || die "Could not commit"

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:YoungFrog/youngfrog.github.io master:gh-pages ||
    die "Could not force push to github"

rm -rf "$target"
