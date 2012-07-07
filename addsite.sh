# 1. Create the directories and bogus index file
mkdir -p /home/mitch/www/$1/public_html/
mkdir /home/mitch/www/$1/logs/
touch /home/mitch/www/$1/logs/error.log
touch /home/mitch/www/$1/logs/access.log
echo "$1 coming soon" > /home/mitch/www/$1/public_html/index.html

# 2. Create the Apache config
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$1
echo "    ServerAdmin mitch.malone@me.com" >> /etc/apache2/sites-available/$1
echo "    ServerName $1" >> /etc/apache2/sites-available/$1
echo "    ServerAlias www.$1" >> /etc/apache2/sites-available/$1
echo "    DocumentRoot /home/mitch/www/$1/public_html/" >> /etc/apache2/sites-available/$1
echo "    ErrorLog /home/mitch/www/$1/logs/error.log" >> /etc/apache2/sites-available/$1
echo "    CustomLog /home/mitch/www/$1/logs/access.log combined" >> /etc/apache2/sites-available/$1
echo "</VirtualHost>" >> /etc/apache2/sites-available/$1

# 3. Add site
a2ensite $1

# 4. Restart Apache
/etc/init.d/apache2 reload
