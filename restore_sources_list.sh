#!/bin/bash
# restore_sources_list.sh
# 用來還原 sources.list，恢復到破壞前的狀態

echo "♻︎ 正在還原 sources.list..."

if [ -f /etc/apt/sources.list.bak ]; then
    sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list
    echo "✔ sources.list 還原完成。"
    echo "♻︎ 執行 apt update 以同步套件清單..."
    sudo apt update
else
    echo "⚠︎ 找不到 /etc/apt/sources.list.bak，無法還原。"
fi
