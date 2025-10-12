#!/bin/bash

# LaTeX 编译脚本 for visapp.tex
# 用于编译学术论文，包含参考文献和交叉引用

echo "开始编译 visapp.tex..."

# 设置工作目录
cd "$(dirname "$0")"

# 检查是否存在 visapp.tex
if [ ! -f "visapp.tex" ]; then
    echo "错误: 找不到 visapp.tex 文件"
    exit 1
fi

# 清理之前的编译文件
echo "清理之前的编译文件..."
rm -f visapp.aux visapp.bbl visapp.blg visapp.log visapp.out visapp.toc visapp.pdf visapp.synctex.gz

# 第一次编译 - 生成 .aux 文件 (启用同步功能)
echo "第一次编译 (pdflatex with sync)..."
pdflatex -interaction=nonstopmode -synctex=1 visapp.tex

# 检查第一次编译是否成功（即使有警告也继续）
if [ $? -ne 0 ]; then
    echo "错误: 第一次 pdflatex 编译失败"
    exit 1
fi

# 编译参考文献
echo "编译参考文献 (bibtex)..."
bibtex visapp

# 检查 bibtex 是否成功
if [ $? -ne 0 ]; then
    echo "警告: bibtex 编译可能有问题，但继续执行..."
fi

# 第二次编译 - 处理参考文献引用 (启用同步功能)
echo "第二次编译 (pdflatex with sync)..."
pdflatex -interaction=nonstopmode -synctex=1 visapp.tex

# 检查第二次编译是否成功
if [ $? -ne 0 ]; then
    echo "错误: 第二次 pdflatex 编译失败"
    exit 1
fi

# 第三次编译 - 确保所有交叉引用正确 (启用同步功能)
echo "第三次编译 (pdflatex with sync)..."
pdflatex -interaction=nonstopmode -synctex=1 visapp.tex

# 检查第三次编译是否成功
if [ $? -ne 0 ]; then
    echo "错误: 第三次 pdflatex 编译失败"
    exit 1
fi

# 检查最终 PDF 是否生成
if [ -f "visapp.pdf" ]; then
    echo "✅ 编译成功! 生成的 PDF 文件: visapp.pdf"
    echo "文件大小: $(ls -lh visapp.pdf | awk '{print $5}')"
    if [ -f "visapp.synctex.gz" ]; then
        echo "✅ 同步文件已生成: visapp.synctex.gz"
        echo "现在可以在编辑器中实现 PDF 和源代码的双向定位！"
    fi
else
    echo "❌ 编译失败: 未生成 PDF 文件"
    exit 1
fi

echo "编译完成!"
