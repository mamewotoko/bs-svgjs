bs-svgjs [![CI](https://github.com/mamewotoko/bs-svgjs/actions/workflows/build.yml/badge.svg)](https://github.com/mamewotoko/bs-svgjs/actions/workflows/build.yml) [![Build Status](https://travis-ci.com/mamewotoko/bs-svgjs.svg?branch=master)](https://travis-ci.com/mamewotoko/bs-svgjs)
=============

A Bucklescript binding of svgjs 2.6.

Setup
------

```bash
npm install
```

Build
------

```bash
./build.sh
```

Run
---

Run http server

```bash
./run.sh
```
browse http://localhost:8080

Build doc on Mac
--------------------

```bash
yarn add bsdoc@6.0.4-alpha

./build.sh
npm run doc-init
npm run build:doc
```

[./docs](./docs) coantains document of svgjs

TODO
----
* update to svgjs 3.0
* test

Reference
-----------

* [SVG.js](https://svgjs.dev/docs/2.7/)
* [BsDoc](https://reasonml-community.github.io/bsdoc/docs/bsdoc/#no-bs-publishing-to-github)

-----
Takashi Masuyama < mamewotoko@gmail.com >
http://mamewo.ddo.jp/
