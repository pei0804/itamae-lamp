# PHPのインストール
package 'php'

# PHPのプラグインをインストール
package 'php-mysqlnd php-gd php-intl php-mbstring'

# php.iniのバックアップ
execute 'php.ini backup' do
    command 'cp /etc/php.ini /etc/php.ini.org'
end