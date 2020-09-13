sed -i 's/'$VUE_APP_BASE_API'/VUE_APP_BASE_API/g' /pluto-admin/dist/static/js/app.*.js
python3 -m http.server $PORT
