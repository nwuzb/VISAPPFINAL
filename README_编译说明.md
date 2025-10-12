# LaTeX 编译说明

本项目包含多个编译脚本来编译 `visapp.tex` 文件。

## 编译脚本

### 1. 完整编译 (推荐)
```bash
./compile.sh
```
- 执行完整的 LaTeX 编译流程
- 包含三次 pdflatex 编译和一次 bibtex 编译
- 处理参考文献和交叉引用
- 生成最终的 PDF 文件

### 2. 快速编译
```bash
./quick_compile.sh
```
- 仅执行单次 pdflatex 编译
- 不处理参考文献
- 适合快速预览

### 3. 使用 Makefile
```bash
make all          # 完整编译
make quick        # 快速编译
make clean        # 清理临时文件
make distclean    # 完全清理（包括 PDF）
make view         # 打开生成的 PDF
make help         # 显示帮助信息
```

### 4. Windows 批处理文件
```cmd
compile.bat
```
- Windows 系统下的完整编译脚本

## 编译要求

- LaTeX 发行版 (如 TeX Live, MiKTeX)
- pdflatex 编译器
- bibtex 工具

## 输出文件

编译成功后会在当前目录生成：
- `visapp.pdf` - 主要的 PDF 文件
- 各种临时文件 (.aux, .log, .out 等)

## 故障排除

如果编译失败，请检查：
1. 是否安装了完整的 LaTeX 发行版
2. 所有图片文件是否存在于 `pictures/` 目录中
3. 参考文献文件 `visapp.bib` 是否存在

## 注意事项

- 首次编译可能需要较长时间
- 如果修改了参考文献，需要运行完整编译
- 图片文件路径必须正确
