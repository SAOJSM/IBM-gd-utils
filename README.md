# IBM-gd-utils

IBM Cloud Fonudray + gd-utils + Github Actions

### [English Version](#english-version-1)

### 原項目 [gd-utils](https://github.com/iwestlin/gd-utils)


> **效果：用GitHub Actions全自動安裝gd-utils機器人到IBM Cloud Fonudray容器內，並且每周五12點定時重啟IBM CF**

> **重要提示：因為IBM CF每次重啟後容器內應用會恢覆原始狀態，故重啟期間進行的設置和轉存記錄都會被清除！有這方面需求的謹慎選擇是否安裝。** （也可能是我的設置問題，有解請告訴我）

>
>前提須知：
>
>1、申請IBM Cloud Fonudray賬號，記錄下賬號和密碼。（申請完成後登錄就不用管他了，不需要手動建立容器。若安裝後出現500錯誤，原因是容器地址不對，需要登錄IBM找到容器設置手動改成us-south.cf.appdomain.cloud的樣子，然後檢查前面的容器名和你設置的是否一致，改好後重新走第四步）
>
>2、申請tg機器人，記錄下token和自己的username(t.me/username)。多個用`username', '其他人的username`這個格式，注意起始處沒有引號
>
>3、獲得service account文件，並打包成accounts.zip上傳到能下載的地方，然後記錄下載url（可以直接上傳到自己的GoogleDrive）
>
>4、在自己的GD團隊盤里面設置一個默認目錄，記錄下目錄ID
>

# 全自動安裝

第一步：注冊IBM Cloud Fonudray記住賬號密碼 cloud.ibm.com

第二步：打開GitHub注冊，然後Fork本項目（順便點個Star）

第三步：在你自己的GitHub項目里面點Settings（設置）然後點Secrets（隱私）新建如下內容

Key | Value | Type | Required
-- | -- | -- | --
IBM_MAIL | IBM Cloud的登錄郵箱 | Secrets | Yes
IBM_PWD | IBM Cloud的登錄密碼 | Secrets | Yes
IBM_APP_NAME | CF App的名稱（自己取一個） | Secrets | Yes
TG_TOKEN | Telegram機器人token | Secrets | Yes
TG_USERNAME | 你的Telegram username | Secrets | Yes
DRIVE_ID | GD默認保存目錄ID | Secrets | Yes
SA_DLURL | SA打包文件accounts.zip下載url | Secrets | Yes


第四步：在你自己的GitHub項目里面，點Actions然後點左側IBM Cloud Auto Install切換，然後點 Run workflow 開始全自動安裝(看不到Auto Install的話，點開yml文件隨便加一空行保存)

結束

**打開你自己建的TGbot，輸入/help**



# 手動安裝

第一步：注冊IBM Cloud Fonudray並自行新建容器

第二步：打開IBM Cloud Shell輸入以下代碼 (shell在網頁右上角)

 ```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/artxia/IBM-gd-utils/master/install.sh && chmod +x install.sh  && ./install.sh
 ```

結束



# English Version
### by [@ssnjrthegr8](https://github.com/ssnjrthegr8)

<details>
<summary>Stuff</summary>
 
Effect: Use GitHub Actions to automatically install the gd-utils robot into the IBM Cloud Foundry container, and restart IBM CF at 12 o'clock every Friday

Important Note: Because the application in the container will be restored to its original state after each restart of IBM CF, the settings and dump records during the restart will be cleared! If you have this requirement, choose whether to install it carefully. ** (It may also be a problem with my settings, please tell me if you have a solution)

>
>Prerequisites:
>
>1. Apply for an IBM Cloud Foundry account and record the account and password. (After the application is completed, log in and you don’t have to worry about it. You don’t need to manually create the container. If a 500 error occurs after installation, the reason is that the container address is incorrect. You need to log in to IBM to find the container setting and manually change it to us-south.cf.appdomain.cloud , And then check whether the container name in front is consistent with the one you set, and re-take the fourth step after correcting
>
>2. Apply for tg robot, record the token and your username (t.me/username). Multiple use `username','other people's username` format, note that there is no quotation mark at the beginning
>
>3. Obtain the service account file, package it into accounts.zip and upload it to a place where it can be downloaded, and then record the download url (you can upload it directly to your GoogleDrive)
>
>4. Set a default directory in your GD team disk and record the directory ID
>
</details>

# Automatic installation

Step 1: [Sign up for IBM Cloud Foundry](https://cloud.ibm.com/) and note down the emailid and password. Choose your region to be USA for the setup to be of least hassle.

Step 2: Fork this repo.

Step 3: Open your forked repo and go to settings. On your left you will see a tab called Secrets, click that. Click on New Repo Secret and add the key and its respective value one by one. The list is given below:

Key | Value | Type | Required
-- | -- | -- | --
IBM_MAIL | IBM Cloud login email | Secrets | Yes
IBM_PWD | IBM Cloud login password | Secrets | Yes
IBM_APP_NAME | The name of the CF App (take one yourself) | Secrets | Yes
TG_TOKEN | Telegram robot token | Secrets | Yes
TG_USERNAME | Your Telegram username | Secrets | Yes
DRIVE_ID | GD default save directory ID | Secrets | Yes
SA_DLURL | SA package file accounts.zip download url | Secrets | Yes

Step 4: Now go to actions and click on the green I understand my workflow button and on the left you will see IBM auto install, open that. Choose Run Workflow.

Step 5: After the installation has finished, go to https://cloud.ibm.com/resources and click on Cloud Foundry apps. There will be an app with same value you gave for IBM_APP_NAME. Click on the app name and on your upper right there will be an Actions... button. Click that and choose edit routes. Edit it so that it looks like this:
`https://value-of-your-IBM_APP_NAME.us-south.cf.appdomain.cloud/`. If it already looks like that, then skip this step.

![hfgdfg](https://user-images.githubusercontent.com/50513568/102684302-40446200-4212-11eb-9238-8f082e0cbbad.png)

Step 6: Go to your repo > actions > IBM auto restart and enable it, ignore all warnings.

**Open the TGbot you built, and type /help**

<details>
<summary>Manual installation</summary>
Step 1: Register for IBM Cloud Foundry and create a new container by yourself

Step 2: Open the IBM Cloud Shell and enter the following code (shell is in the upper right corner of the page)

 ```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/artxia/IBM-gd-utils/master/install.sh && chmod +x install.sh && ./install.sh
 ```
</details>
