#! /bin/bash
# build sample
set -e

cd $(dirname $0)

npm run build
mkdir -p examples/js
$(npm bin)/browserify -t babelify examples/src/main.bs.js > examples/js/main.browser.js

# TODO; remove
# by loading Svgjs, SVG is defined as a function
sed -i "" 's/Svgjs.SVG/SVG/g' examples/js/main.browser.js
cp node_modules/@svgdotjs/svg.js/dist/svg.min.js examples/js

# bsdoc for linux/windows are not included in bsdoc package
UNAME=$(uname)
if [ "$UNAME" = "Darwin" ]; then
    $(npm bin)/yarn add bsdoc@6.0.4-alpha
    npm run doc-init
    npm run build:doc
elif [ "$UNAME" = "Linux" ]; then
    npm install @mauna-ai/bsdoc-linux
    npm run doc-init
    npm run build:doc
fi
