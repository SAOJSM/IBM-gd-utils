#!/bin/bash
echo
echo "============== <<部署之前先滿足以下條件>> =============="
echo "1.你的應用名稱"
echo "2.你的應用內存大小"
echo "3.你的應用所在區域"
echo "4.telegram機器人token"
echo "5.telegram賬號ID"
echo "6.默認目的google drive團隊盤ID"
echo "7.獲得SA文件，並打包成accounts.zip文件"
echo "------------------------------------------------"
read -s -n1 -p "已做好準備請按任意鍵開始"
echo
echo "------------------------------------------------"

SH_PATH=$(cd "$(dirname "$0")";pwd)
cd ${SH_PATH}

create_mainfest_file(){
    echo "進行配置。。。"
    read -p "請輸入你的應用名稱：" IBM_APP_NAME
    echo "應用名稱：${IBM_APP_NAME}"
    read -p "請輸入你的應用內存大小(默認256)：" IBM_MEM_SIZE
    if [ -z "${IBM_MEM_SIZE}" ];then
    IBM_MEM_SIZE=256
    fi
    echo "內存大小：${IBM_MEM_SIZE}"
    read -p "請輸入你的應用所在區域(不知道的看應用URL，cf前面的us-south就是)：" IBM_APP_REGION
    echo "應用所在區域：${IBM_APP_REGION}"

    read -p "請輸入機器人token：" BOT_TOKEN
    while [[ "${#BOT_TOKEN}" != 46 ]]; do
    echo "機器人TOKEN輸入不正確，請重新輸入"
    read -p """請輸入機器人token：" BOT_TOKEN
    done

    read -p "請輸入使用機器人的telegram賬號ID：" TG_USERNAME
    echo "你的TG賬號${TG_USERNAME}"

    read -p "請輸入轉存默認目的地團隊盤ID：" DRIVE_ID
    while [[ "${#DRIVE_ID}" != 19 && "${#DRIVE_ID}" != 33 ]]; do
    echo "你的Google team drive ID輸入不正確"
    read -p "請輸入轉存默認目的地ID：" DRIVE_ID
    done

    cd ~ &&
    sed -i "s/cloud_fonudray_name/${IBM_APP_NAME}/g" ${SH_PATH}/IBM-gd-utils/manifest.yml &&
    sed -i "s/cloud_fonudray_mem/${IBM_MEM_SIZE}/g" ${SH_PATH}/IBM-gd-utils/manifest.yml && 
    sed -i "s/bot_token/${BOT_TOKEN}/g" ${SH_PATH}/IBM-gd-utils/gdutil/config.js &&
    sed -i "s/your_tg_username/${TG_USERNAME}/g" ${SH_PATH}/IBM-gd-utils/gdutil/config.js && 
    sed -i "s/DEFAULT_TARGET = ''/DEFAULT_TARGET = '${DRIVE_ID}'/g" ${SH_PATH}/IBM-gd-utils/gdutil/config.js&&
    sed -i "s/23333/8080/g" ${SH_PATH}/IBM-gd-utils/gdutils/server.js &&
    sed -i "s@https_proxy='http://127.0.0.1:1086' nodemon@pm2-runtime start@g" ${SH_PATH}/IBM-gd-utils/gdutil/package.json&&
    sed -i '/scripts/a\    "preinstall": "npm install pm2 -g",' ${SH_PATH}/IBM-gd-utils/gdutil/package.json&&
    sed -i '/repository/a\  "engines": {\n    "node": "12.*"\n  },' ${SH_PATH}/IBM-gd-utils/gdutil/package.json&&
    sed -i '/dependencies/a\    "pm2": "^3.2.8",' ${SH_PATH}/IBM-gd-utils/gdutil/package.json
    echo "配置完成。"
}

clone_repo(){
    echo "進行初始化。。。"
    git clone https://github.com/SAOJSM/IBM-gd-utils
    cd IBM-gd-utils
    git submodule update --init --recursive
    cd gdutils/sa
    echo "請點擊網頁右上角的上傳功能，上傳sa打包成的accounts.zip文件，注意命名和壓縮格式要和示例相同"
    read -s -n1 -p "已做好準備請按任意鍵開始"
    while [ ! -f ${SH_PATH}/accounts.zip ]; do
    echo "。。。。。。上傳文件錯誤，請重新上傳"
    read -p "按回車鍵重試"
    done
    echo "正在解壓。。。"
    cp -r ${SH_PATH}/accounts.zip  ${SH_PATH}/IBM-gd-utils/gdutils/sa/
    unzip -oj accounts.zip
    sleep 10s
    echo "初始化完成。"
}

install(){
    echo "進行安裝。。。"
# 解除sudu權限限制
    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
    sed -i '$a\export PATH=~/.npm-global/bin:$PATH' ~/.profile
    source ~/.profile
#
    cd IBM-gd-utils/gd-utils
    npm i
    cd ..
    ibmcloud target --cf
    ibmcloud cf push
    echo "安裝完成。"
    sleep 3s
	echo "檢查是否部署成功。。。"
    echo ${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
    curl ${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
    curl -F "url=https://${IBM_APP_NAME}.${IBM_APP_REGION}.cf.appdomain.cloud/api/gdurl/tgbot" 'https://api.telegram.org/bot${BOT_TOKEN}/setWebhook'
    echo
}

clone_repo
create_mainfest_file
install
exit 0
