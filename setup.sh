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
		cp -f "${HOMEDIR}${HTMLDIR}${JDIR}/css/"* "$HOMEDIR$HTMLDIR/css"
		cp -f "${HOMEDIR}${HTMLDIR}${JDIR}/lib/"* "$HOMEDIR$HTMLDIR/lib"
		cp -f "${HOMEDIR}${HTMLDIR}${JDIR}/img/"* "$HOMEDIR$HTMLDIR/img"
		cp -f "${HOMEDIR}${HTMLDIR}${LPDIR}/swfData/"* "$HOMEDIR$HTMLDIR/swfData"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/css"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/lib"
		rm -rf "${HOMEDIR}${HTMLDIR}${JDIR}/img"
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	else
		mv "${HOMEDIR}${HTMLDIR}${JDIR}/"* $HOMEDIR$HTMLDIR
	fi
fi

mkdir "${HOMEDIR}${HTMLDIR}/collage/result"
chmod 777 "${HOMEDIR}${HTMLDIR}/collage/result"

sed -i -e "s/HOMEDIR/$INPUT/g" ipad/preview2.php


#
echo -n "ドメインを入力(Ex:test.pitcom.jp)："
read INPUT
sed -i -e "s/SUBDOMAIN/$INPUT/g" setup2016.json
sed -i -e "s/SUBDOMAIN/$INPUT/g" app/mid.json

echo -n "案件IDを入力："
read INPUT
sed -i -e "s/PROJECT/$INPUT/g" setup2016.json
sed -i -e "s/PROJECT/$INPUT/g" app/mid.json

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