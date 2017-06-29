#!/bin/bash

HOMEDIR="/home/pituser"
HTMLDIR="/public_html"
LPDIR="/LivePITPackage"
JDIR="/Johoo"

echo -n "ホームディレクトリ(デフォルト:/home/pituser)："
read INPUT

if [ $INPUT != "" ]
then
	HOMEDIR=$INPUT
fi

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
		mv -f "${HOMEDIR}${HTMLDIR}${JDIR}/img/"* "$HOMEDIR$HTMLDIR/img"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/css"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/lib"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/img"
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	else
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	fi
fi


sed -i -e "s/HOMEDIR/$INPUT/g" ipad_demo/preview2.php


#
echo -n "サブドメインを入力："
read INPUT
sed -i -e "s/SUBDOMAIN/$INPUT/g" setup2016.json
sed -i -e "s/SUBDOMAIN/$INPUT/g" app/mid.json

echo -n "縦ブロック数："
read INPUT
sed -i -e "s/0000/$INPUT/g" setup2016.json
sed -i -e "s/0000/$INPUT/g" app/mid.json

echo -n "横ブロック数："
read INPUT
sed -i -e "s/1111/$INPUT/g" setup2016.json
sed -i -e "s/1111/$INPUT/g" app/mid.json

rm -rf ${HOMEDIR}${HTMLDIR}${LPDIR}
rm -rf ${HOMEDIR}${HTMLDIR}${JDIR}

echo "セットアップ完了"