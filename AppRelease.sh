#!/usr/bin/env bash 

#APP发布构建脚本

#判断系统类型：
#			0:Mac
#			1:Ubuntu
#			2:Other
funSystem()
{
	a=`uname  -a`
	b="Darwin"
	c="Linux"
	type=0

	if [[ $a =~ $b ]];then
	    # echo "Mac"
	    type=0
	elif [[ $a =~ $d ]];then
	    # echo "Linux"
	    type=1
	else
	    # echo $a
	    type=2
	fi
	return $type
}


#构建swift
funBuildSwift(){
	clear
	echo App构建中......

	PROJECT_DIR=$(pwd)
	Products_DIR=
	funSystem
	type=$?
	if [[ $type == 0 ]]; then
		Products_DIR=${PROJECT_DIR}/Products/Mac
	elif [[ $type == 1 ]]; then
		Products_DIR=${PROJECT_DIR}/Products/Linux 
	else
		Products_DIR=${PROJECT_DIR}/Products/Other
	fi

	swift build -c release
	mkdir -p $Products_DIR
	cp -rf ${PROJECT_DIR}/.build/release/Run ${Products_DIR}
	cp -rf ${PROJECT_DIR}/Public ${Products_DIR}
	cp -rf ${PROJECT_DIR}/Resources ${Products_DIR}

	echo App构建成功！
	echo App路径：$Products_DIR
}

#打开构建目录
funOpenDir(){
	# echo 打开APP构建目录
	PROJECT_DIR=$(pwd)
	funSystem
	type=$?
	if [[ $type == 0 ]]; then
		open ${PROJECT_DIR}/Products	
	else
		nautilus ${PROJECT_DIR}/Products
	fi

}

funBuildSwift
funOpenDir



