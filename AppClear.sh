#!/usr/bin/env bash 

#APP清理脚本

echo 项目清理中......


PROJECT_DIR=$(pwd)

rm -rf ${PROJECT_DIR}/Products
rm -rf ${PROJECT_DIR}/.build/x86_64-unknown-linux-gnu
rm -rf ${PROJECT_DIR}/.build/x86_64-apple-macosx
rm -rf ${PROJECT_DIR}/.build/debug
rm -rf ${PROJECT_DIR}/.build/release


echo 项目清理完成!