#!/usr/bin/env sh

######################################################################
# @author      : cromarmot (yexiaorain@gmail.com)
# @file        : update
# @created     : 星期二 8月 25, 2020 15:54:33 CST
#
# @description : 
######################################################################

TMPDIR=/tmp/v2nutpicker

yarn doc
rm -rf $TMPDIR
mkdir -p $TMPDIR
cp -r docs $TMPDIR
rm -rf $TEMPDIR/docs/*.md
cd $TMPDIR
git init
git remote add origin git@github.com:CroMarmot/v2-nut-picker.git
git checkout -b docs
git add .
git commit -m "auto update by script"
git push origin docs -f
