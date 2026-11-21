#!/bin/sh
# Wraps index.html (the artifact source) into a standalone page in docs/ for hosting.
cd "$(dirname "$0")"
mkdir -p docs
[ -d images ] && cp -R images docs/
{
  printf '<!doctype html>\n<html lang="ar" dir="rtl">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<style>body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  sed -n '1,/^<header/p' index.html | sed '$d'
  printf '</head>\n<body>\n'
  sed -n '/^<header/,$p' index.html
  printf '</body>\n</html>\n'
} > docs/index.html
echo "Built docs/index.html"
