# LSAP-Homework2 — APT 套件管理與系統修復
本專案提供一個作業用的 Linux Lab 環境建置步驟

## 檔案內容

- `homework2_break_environment.sh`：破壞環境指令腳本（製造 sources.list 破壞 + dpkg 半安裝錯誤）
- `restore_sources_list.sh`：用來還原 sources.list，恢復到破壞前的狀態
- `README.md`：本說明文件

## 建置步驟

**所需檔案：homework2_break_environment.sh**

1. 在 VirtualBox 建立新 VM（請將 username 跟 password 都改為 student，以方便學生登入）
2. 設定網路：打開 VirtualBox → 你新建的 VM →「設定（Settings）」→「網路（Network）」
    - **【網路卡1】（Adapter 1）**
      - 啟用網路卡（Enable Network Adapter）
      -  **連線方式（Attached to）**：選「**NAT**」
   
    - **【網路卡2】（Adapter 2）**
      - 啟用網路卡（Enable Network Adapter）
      - **連線方式（Attached to）**：選「**Host-Only Adapter**」
      - 主機介面（Name）選：`vboxnet0` 或 預設Host-Only網路
    
3. 啟動 VM，確認 SSH server 有開（通常 Ubuntu 預設沒開，需安裝）：
    
    ```bash
    sudo apt update
    sudo apt install openssh-server
    sudo systemctl start ssh
    sudo systemctl enable ssh
    ```
    
5. 確認 IP 地址 及 確認 VM 可以上外網：
    1. 進入你的 VM 端：`ip a` <br>
       理論上會看到兩個網卡，例如：
        | 網卡名稱 | 功能 | 範例IP |
        | --- | --- | --- |
        | enp0s3（或 eth0） | NAT（上外網） | 10.0.2.15 |
        | enp0s8（或 eth1） | Host-Only（內部網） | 192.168.56.3 |
        
        （如果你用的是Ubuntu20/22，網卡名稱可能是 enp0s3 / enp0s8，舊版是eth0 / eth1）
        
        **重點**：那段 `192.168.56.x` 就是 Host-Only 網段的 IP，待會要用來 scp 傳輸檔案！
       
    2. 繼續在 VM 端輸入：
        ```bash
        ping google.com
        sudo apt update
        ```
        `ping google.com` 有輸出則為正常，`sudo apt update` 原則上都會正常（不會有 Error）。
        
6. 本機用 scp 傳檔到 VM：
   在本機端 Terminal 上：
    ```bash
    scp Desktop\homework2_break_environment.sh student@192.168.56.3:/home/student/
    ```
    （注意換成你的帳號和VM的Host-Only IP，如果 username 不是使用 student 的話）
   
    
8. 賦予檔案執行權限：在 VM 端
    
    ```bash
    chmod +x ~/homework2_break_environment.sh
    ```

9. 執行破壞環境的腳本
    
    ```bash
    ~/homework2_break_environment.sh
    ```
    理論上會長這樣，有 Warning 是正常的：
    ![螢幕擷取畫面 2025-04-28 140106](https://github.com/user-attachments/assets/ec22938e-ff9c-4c1d-9b28-6e6d7d71d7e1)
    
10. 打包成 `.ova` 檔：關機 → VirtualBox → File → Export Appliance → 匯出為 LSAP-Homework2.ova
