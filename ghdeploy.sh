#!/bin/sh

# gh pages deploy.
# commits to a git branch.
# will exit if anything fails.
# if so, checkout master, delete gh-pages-deploy

deploy=gh-pages-deploy
build=dist/

git diff-index --quiet --cached HEAD
if [[ $? -ne 0 ]]; then
  echo 'Error: git index has staged changes.'
  echo '`git stash` or `git reset` and try agan.'
  exit -1
fi

set -e # exit on any failure
echo '==> deploying website to github pages'
git checkout -b $deploy
# make clean
# make
grunt clean
grunt
git add -f $build
git commit -m "payload"
git checkout master
git filter-branch --subdirectory-filter $build -f $deploy
git push -f origin $deploy:gh-pages
git branch -D $deploy
echo '==> done! :)'
