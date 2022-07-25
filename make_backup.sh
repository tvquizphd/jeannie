if test -z "$1" 
then
  echo "First argument must be backup directory"
  exit 1
fi

if test -z "$2" 
then
  echo "Second argument must be secret config"
  exit 1
fi

mkdir -p $1/var/www/
cp -R /var/www/tvquizphd.com/ $1/var/www/tvquizphd.com
mysqldump -u j -p modx_modx > $1/modx_modx.sql
cp $2 $1/secret_config.xml
