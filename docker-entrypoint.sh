#!/bin/bash

sed -i 's/VUE_APP_BASE_API/'$VUE_APP_BASE_API'/g' /app/static/js/app.*.js
cd /app && python3 -m http.server $PORT
