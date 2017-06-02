# timezone設定
execute 'set timezone' do
    user "root"
    command <<-EOL
        cp -p /usr/share/zoneinfo/Japan /etc/localtime
        echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
        echo 'UTC=false' >> /etc/sysconfig/clock
    EOL
end

# 言語設定
file '/etc/sysconfig/i18n' do
    action :edit
    user "root"
    block do |content|
        content.gsub!("en_US", "ja_JP")
    end
end

# firewalld停止、無効化
service 'firewalld' do
    action [:disable, :stop]
end