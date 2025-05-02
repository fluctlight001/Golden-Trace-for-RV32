#!/bin/bash

# 遍历当前目录下所有的 .ans 文件
for file in golden_trace/*.ans; do
    # 统计文件的行数
    line_count=$(wc -l < "$file")
    
    # 创建一个临时文件
    temp_file=$(mktemp)
    
    # 将行数写入临时文件的第一行
    echo "$line_count" > "$temp_file"
    
    # 将原文件的内容追加到临时文件
    cat "$file" >> "$temp_file"
    
    # 用临时文件替换原文件
    mv "$temp_file" "$file"
done