if test -z "$1" 
then
  echo "First argument must be backup directory"
  exit 1
fi

MODX_MODX_SQL="$1/modx_modx.sql"
CONFIG="$1/secret_config.xml"
TARGET="/var/www/tvquizphd.com"
ZIP="modx-3.0.1-pl-sdk.zip"
V="3.0.1"

msql -p -u j < DROP_modx_modx.sql
wget "https://modx.com/download/direct/$ZIP"
php installmodx.php --config=$CONFIG --zip=$ZIP --target=$TARGET --version=$V --installmode=new
mysql -p -u j modx_modx < $MODX_MODX_SQL
rsync -a $1$TARGET $TARGET
