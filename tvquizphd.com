server {
    server_name tvquizphd.com www.tvquizphd.com;
    root /var/www/tvquizphd.com;

    index index.php;
    client_max_body_size 30M;

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot

    location @modx-rewrite {
        rewrite ^/(.*)$ /index.php?q=$1&$args last;
    }

    location / {
        absolute_redirect off;
        try_files $uri $uri/ @modx-rewrite;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(.*)$;
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_ignore_client_abort on;
        fastcgi_param  SERVER_NAME $http_host;
        fastcgi_param HTTP_PROXY "";
    }

    location ~ /\.ht {
        deny  all;
    }

    location ~ ^/(\.(?!well_known)|_build|_gitify|_backup|core|config.core.php) {
        return 404;
    }

    ssl_certificate /etc/letsencrypt/live/tvquizphd.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/tvquizphd.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

}
