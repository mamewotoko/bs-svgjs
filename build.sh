#! /bin/bash
# build sample
set -e

cd $(dirname $0)

npm run build
mkdir -p examples/js
$(npm bin)/browserify -t babelify examples/src/main.bs.js > examples/js/main.browser.js

cp node_modules/@svgdotjs/svg.js/dist/svg.min.js examples/js

# bsdoc for linux/windows are not included in bsdoc package
npm run doc-init
npm run build:doc
