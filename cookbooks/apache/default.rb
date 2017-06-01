# Apacheインストール
package 'httpd'

# httpd.confのバックアップ
execute 'httpd.conf backup' do
    command 'cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org'
end

# wwwユーザ追加
execute 'add www user' do
    user "root"
    command <<-EOL
        useradd www
        gpasswd -a apache www
        chown -R www:apache /var/www/html
    EOL
end