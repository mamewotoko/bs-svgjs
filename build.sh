#! /bin/bash
# build sample
set -e
npm run build
mkdir js
$(npm bin)/browserify -t babelify src/main.bs.js > js/main.browser.js

# TODO; remove 
# by loading Svgjs, SVG is defined as a function
sed -i -e 's/Svgjs.SVG/SVG/g' js/main.browser.js
