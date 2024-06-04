#!/bin/sh

docker build -t my-php-app1 . --no-cache

docker run \
    -it \
    --rm \
    -p 8082:80 \
    -p 8081:443 \
    -p 2019:2019 \
    -e CADDY_GLOBAL_OPTIONS=debug \
    --name my-running-app \
    my-php-app1



curl localhost:2019/load \
    -H "Content-Type: application/json" \
    -d @- << EOF
    {"apps":{"frankenphp":{},"http":{"servers":{"srv0":{"listen":[":80"],"routes":[{"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"vars","root":"public/"},{"encodings":{"br":{},"gzip":{},"zstd":{}},"handler":"encode","prefer":["zstd","br","gzip"]}]},{"handle":[{"handler":"static_response","headers":{"Location":["{http.request.orig_uri.path}/"]},"status_code":308}],"match":[{"file":{"try_files":["{http.request.uri.path}/index.php"]},"not":[{"path":["*/"]}]}]},{"handle":[{"handler":"rewrite","uri":"{http.matchers.file.relative}"}],"match":[{"file":{"split_path":[".php"],"try_files":["{http.request.uri.path}","{http.request.uri.path}/index.php","index.php"]}}]},{"handle":[{"handler":"php","split_path":[".php"]}],"match":[{"path":["*.php"]}]},{"handle":[{"handler":"file_server"}]}]}],"match":[{"host":["localhost"]}],"terminal":true}]}}}},"logging":{"logs":{"default":{"level":"DEBUG"}}}}
EOF
