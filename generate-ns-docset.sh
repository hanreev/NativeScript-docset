#!/bin/bash

export TYPEDOC_DASH_ICONS_PATH=../ns-dash-icons

rm -rf NativeScript.docset
rm -rf NativeScript.tgz

if [[ ! -d typedoc-dash-theme || ! -d NativeScript ]]; then
  git submodule update --init
fi

if [ ! -d typedoc-dash-theme/node_modules ]; then
  cd typedoc-dash-theme
  yarn install
  cd ..
fi

cd NativeScript
if [ ! -d "node_modules" ]; then
  npm i
fi

node_modules/.bin/typedoc --tsconfig tsconfig.typedoc.json \
  --name NativeScript \
  --out ../NativeScript.docset \
  --theme ../typedoc-dash-theme/bin \
  --includeDeclarations \
  --excludeExternals \
  --externalPattern "**/+(tns-core-modules|module).d.ts"

cd ..

tar --exclude '.DS_Store' -cvzf NativeScript.tgz NativeScript.docset
