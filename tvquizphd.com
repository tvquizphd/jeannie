server {
    server_name tvquizphd.com www.tvquizphd.com;
    root /var/www/tvquizphd.com;

    index index.php;
    client_max_body_size 30M;

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        # Mitigate https://httpoxy.org/ vulnerabilities
        fastcgi_param HTTP_PROXY "";

        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
        fastcgi_index index.php;
        include fastcgi.conf;
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
