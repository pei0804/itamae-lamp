%w(php php-mbstring php-xml php-gd php-pear php-mysqlnd php-intl).each do |pkg|
  package pkg do
    options "--enablerepo=remi-php56"
  end
end

execute "backup php.ini" do
  user "root"
  command "cp /etc/php.ini /etc/php.ini.org"
  not_if "test -f /etc/php.ini.org"
  only_if "test -f /etc/php.ini"
end

file "/etc/php.ini" do
  user "root"
  action :edit
  block do |content|
    content.gsub!(";date.timezone = ", "date.timezone = Asia/Tokyo")
  end
  not_if "grep - E '^date.timezone = Asia/Tokyo' /etc/php.ini"
  only_if "test -f /etc/php.ini"
end

file "/etc/php.ini" do
  user "root"
  action :edit
  block do |content|
    content.gsub!("session.gc_maxlifetime = 1440", "session.gc_maxlifetime = 86400")
  end
  not_if "grep '^session.gc_maxlifetime = 86400' /etc/php.ini"
  only_if "test -f /etc/php.ini"
end
