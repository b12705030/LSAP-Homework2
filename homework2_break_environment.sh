#!/bin/bash
# 製造 sources.list 破壞 + dpkg 半安裝錯誤

echo "⚠︎ 備份 sources.list..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

echo "⚠︎ 插入錯誤的套件來源..."
echo "deb http://fake.archive.ubuntu.com/ubuntu focal main" | sudo tee -a /etc/apt/sources.list

echo "⚠︎ 製造 dpkg 半安裝錯誤（用 cowsay 套件）..."
sudo apt install --download-only cowsay -y    # 先只下載，不裝
cd /var/cache/apt/archives/                   # 找到下載下來的 .deb，進入該資料夾
sudo dpkg --unpack cowsay_*.deb || true       # 故意只解開，不完成安裝

echo "⚠︎ 已經破壞完成，sources.list和dpkg都有問題了。"
echo "⚠︎ 現在請使用 dpkg --audit 檢查系統狀態。"