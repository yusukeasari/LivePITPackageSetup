#!/bin/bash

HOMEDIR="/home/pituser"
HTMLDIR="/public_html"
LPDIR="/LivePITPackage"
JDIR="/Johoo"

if [ -e ${HOMEDIR}${HTMLDIR}${JDIR} ]
then
	echo "tmp dir already exists."
	exit 0
else

	git clone https://github.com/yusukeasari/LivePITPackage.git $HOMEDIR$HTMLDIR$LPDIR
	git clone https://github.com/yusukeasari/Johoo.git $HOMEDIR$HTMLDIR$JDIR

	mv "${HOMEDIR}${HTMLDIR}${LPDIR}/"* $HOMEDIR$HTMLDIR
	if [ -e "${HOMEDIR}${HTMLDIR}/css" ]
	then
		mv -f "${HOMEDIR}${HTMLDIR}${JDIR}/css/"* "$HOMEDIR$HTMLDIR/css"
		mv -f "${HOMEDIR}${HTMLDIR}${JDIR}/lib/"* "$HOMEDIR$HTMLDIR/lib"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/css"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/lib"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/js"
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	else
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	fi
fi

#
echo -n "サブドメインを入力："
read INPUT
sed -i -e "s/DOMAIN/$INPUT/g" setup2016.json
sed -i -e "s/DOMAIN/$INPUT/g" app/mid.json

echo -n "縦ブロック数："
read INPUT
sed -i -e "s/0000/$INPUT/g" setup2016.json
sed -i -e "s/0000/$INPUT/g" app/mid.json

echo -n "縦ブロック数："
read INPUT
sed -i -e "s/1111/$INPUT/g" setup2016.json
sed -i -e "s/1111/$INPUT/g" app/mid.json

rm -rf ${HOMEDIR}${HTMLDIR}${LPDIR}
rm -rf ${HOMEDIR}${HTMLDIR}${JDIR}

echo "セットアップ完了"