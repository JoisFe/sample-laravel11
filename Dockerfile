FROM dunglas/frankenphp:latest-php8.3.7-alpine

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /app
RUN composer install

# RUN curl localhost:2019/load \
#     -H 'Content-Type: application/json' \
#     -d '{"apps":{"frankenphp":{},"http":{"servers":{"srv0":{"listen":[":80"],"routes":[{"handle":[{"handler":"subroute","routes":[{"handle":[{"handler":"vars","root":"public/"},{"encodings":{"br":{},"gzip":{},"zstd":{}},"handler":"encode","prefer":["zstd","br","gzip"]}]},{"handle":[{"handler":"static_response","headers":{"Location":["{http.request.orig_uri.path}/"]},"status_code":308}],"match":[{"file":{"try_files":["{http.request.uri.path}/index.php"]},"not":[{"path":["*/"]}]}]},{"handle":[{"handler":"rewrite","uri":"{http.matchers.file.relative}"}],"match":[{"file":{"split_path":[".php"],"try_files":["{http.request.uri.path}","{http.request.uri.path}/index.php","index.php"]}}]},{"handle":[{"handler":"php","split_path":[".php"]}],"match":[{"path":["*.php"]}]},{"handle":[{"handler":"file_server"}]}]}],"match":[{"host":["localhost"]}],"terminal":true}]}}}},"logging":{"logs":{"default":{"level":"DEBUG"}}}}'
