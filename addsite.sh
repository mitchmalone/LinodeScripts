# 1. Create the directories and bogus index file
mkdir -p /home/mitch/www/$1/public_html/
mkdir /home/mitch/www/$1/logs/
touch /home/mitch/www/$1/logs/error.log
touch /home/mitch/www/$1/logs/access.log
echo "$1 coming soon" > /home/mitch/www/$1/public_html/index.html

# 2. Create the Apache config
sudo echo "<VirtualHost *:80>
>    ServerAdmin mitch.malone@me.com
>    ServerName $1
>    ServerAlias www.$1
>    DocumentRoot /home/mitch/www/$1/public_html/
>    ErrorLog /home/mitch/www/$1/logs/error.log
>    CustomLog /home/mitch/www/$1/logs/access.log combined
> </VirtualHost>" > /etc/apache2/sites-available/$1

# 3. Add site
a2ensite $1

# 4. Restart Apache
sudo /etc/init.d/apache2 reload
