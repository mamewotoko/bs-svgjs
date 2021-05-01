#! /bin/bash
# build sample
set -e
npm run build
#cp node_modules/svgjs/dist/svg.js js/
#$(npm bin)/browserify -t babelify src/svgjs.bs.js src/main.bs.js -o js/main.js
#$(npm bin)/browserify src/main.bs.js -o js/main.js
#$(npm bin)/browserify src/svg.bs.js -o js/svgapp.js

$(npm bin)/browserify -t babelify src/main.bs.js > js/main.browser.js
# by loading Svgjs, SVG is defined as a function
sed -i -e 's/Svgjs.SVG/SVG/g' js/main.browser.js
