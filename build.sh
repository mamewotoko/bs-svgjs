#! /bin/bash
# build sample
set -e

cd $(dirname $0)

npm run build
mkdir -p js
$(npm bin)/browserify -t babelify src/main.bs.js > js/main.browser.js

# TODO; remove 
# by loading Svgjs, SVG is defined as a function
sed -i -e 's/Svgjs.SVG/SVG/g' js/main.browser.js

# bsdoc for linux/windows are not included in bsdoc package
if [ $(uname) = "Darwin" ]; then
    npm run doc-init
    npm run doc
fi
