#! /bin/bash
rm ./public/upload/image/64/*
rm ./public/upload/image/128/*
rm ./public/upload/image/256/*
rm ./public/upload/image/512/*
rm ./public/upload/image/1024/*
rm ./public/upload/image/2048/*
/usr/local/mysql/bin/mysql -u pohome -ppohome pohome < ../scheme/pohome.sql