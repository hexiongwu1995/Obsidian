
把markdown文件转化成html文件的pandoc命令：

```powershell
pandoc "$sourceFile" ` -o "$outputFile" ` --standalone ` --mathjax ` --from markdown+tex_math_dollars ` --embed-resources
%% 注意替换输入和输出路径 %%
```

pandoc模版文件下载地址：

```
https://github.com/jgm/pandoc-templates

https://github.com/EmuxEvans/pandoc-pure-template

```


