

### Style Settings


```StyleSettings
{
  "minimal-style@@code-background@@dark": "#050505",
  "minimal-style@@code-comment@@dark": "#3F8263",
  "minimal-advanced@@hide-markdown": false,
  "minimal-advanced@@cursor": "default",
  "minimal-style@@code-normal@@dark": "#8D8D8D",
  "minimal-style@@code-function@@dark": "#8D8D8D",
  "minimal-style@@code-keyword@@dark": "#8D8D8D",
  "minimal-style@@code-important@@dark": "#8D8D8D",
  "minimal-style@@code-operator@@dark": "#8D8D8D",
  "minimal-style@@code-property@@dark": "#8D8D8D",
  "minimal-style@@code-punctuation@@dark": "#8D8D8D",
  "minimal-style@@code-string@@dark": "#8D8D8D",
  "minimal-style@@code-tag@@dark": "#8D8D8D",
  "minimal-style@@code-value@@dark": "#8D8D8D",
  "minimal-style@@tx1@@dark": "#B0B0B0",
  "minimal-style@@h1-size": "1.6em",
  "minimal-style@@h2-size": "1.4em",
  "minimal-style@@h3-size": "1.2em",
  "minimal-style@@h4-size": "1.2em",
  "minimal-style@@h5-size": "1em",
  "minimal-style@@h6-size": "1em",
  "minimal-style@@h1-color@@dark": "#016FFF",
  "minimal-style@@h2-color@@dark": "#016FFF",
  "minimal-style@@h2-color@@light": "#016FFF",
  "minimal-style@@h1-color@@light": "#016FFF",
  "minimal-style@@h3-color@@dark": "#509660",
  "minimal-style@@h3-color@@light": "#509660",
  "minimal-style@@h4-color@@dark": "#509660",
  "minimal-style@@h4-color@@light": "#509660",
  "minimal-style@@h5-color@@dark": "#A57907",
  "minimal-style@@h6-color@@dark": "#A57907",
  "minimal-style@@h2-l": false,
  "minimal-style@@h2-style": "normal",
  "minimal-style@@h2-weight": 600,
  "minimal-style@@h6-color@@light": "#A57907",
  "minimal-style@@h5-color@@light": "#A57907",
  "minimal-style@@color-blue@@dark": "#00F9FF",
  "minimal-style@@bold-color@@dark": "#D9850C",
  "minimal-style@@bold-modifier": 100,
  "minimal-style@@hl2@@dark": "#7A7A7A"
}
```




以下是Obsidian中minimal Theme主题通过Style Settings插件暴露的所有Minimal专属设置选项的完整中英文对照表

表格按文档中的分类整理，包含设置的英文原名、中文翻译，以及对应的CSS变量（如果有）。部分选项是开关（无变量），部分是针对H1-H6重复的设置（已注明）。

| 分类 (Category)             | 英文设置名称 (English)                      | 中文翻译          | CSS变量 (Variable)                   |
| ------------------------- | ------------------------------------- | ------------- | ---------------------------------- |
| Interface colors          | Base color                            | 基础颜色          | --base-h, --base-s, --base-l       |
|                           | Primary background                    | 主背景色          | --bg1                              |
|                           | Secondary background                  | 次背景色          | --bg2                              |
|                           | Active background                     | 激活背景色         | --bg3                              |
|                           | Border color                          | 边框颜色          | --ui1                              |
|                           | Highlighted border color              | 高亮边框颜色        | --ui2                              |
|                           | Active border color                   | 激活边框颜色        | --ui3                              |
| Accent color              | Accent color                          | 强调色           | --ax1                              |
|                           | Accent color (hover)                  | 强调色（悬停）       | --ax2                              |
|                           | Accent color interactive              | 强调色（交互）       | --ax3                              |
|                           | Text on accent                        | 强调色上的文字颜色     | --sp1                              |
| Extended colors           | Red                                   | 红色            | --red                              |
|                           | Orange                                | 橙色            | --orange                           |
|                           | Yellow                                | 黄色            | --yellow                           |
|                           | Green                                 | 绿色            | --green                            |
|                           | Cyan                                  | 青色            | --cyan                             |
|                           | Blue                                  | 蓝色            | --blue                             |
|                           | Purple                                | 紫色            | --purple                           |
|                           | Pink                                  | 粉色            | --pink                             |
| Active line               | Highlight active line                 | 高亮当前活动行       | (无)                                |
|                           | Active line background                | 活动行背景色        | --active-line-bg                   |
| Blockquotes               | Blockquotes text color                | 引用文字颜色        | --blockquote-color                 |
|                           | Blockquotes background color          | 引用背景色         | --blockquote-background-color      |
|                           | Blockquotes border color              | 引用边框颜色        | --blockquote-border-color          |
|                           | Blockquotes border thickness          | 引用边框粗细        | --blockquote-border-thickness      |
|                           | Blockquotes font size                 | 引用文字大小        | --blockquote-size                  |
|                           | Blockquotes font style                | 引用文字风格        | --blockquote-font-style            |
| Callouts                  | Color blending                        | 颜色混合模式        | --callout-blend-mode               |
| Code blocks               | Code font size                        | 代码字体大小        | --code-font-size                   |
|                           | Scroll long lines                     | 长代码行自动滚动      | (无)                                |
|                           | Code background color                 | 代码背景色         | --code-background                  |
|                           | Code text color                       | 代码文字颜色        | --code-normal                      |
| Syntax highlighting       | Syntax: comments                      | 语法：注释         | --code-comment                     |
|                           | Syntax: functions                     | 语法：函数         | --code-function                    |
|                           | Syntax: keywords                      | 语法：关键字        | --code-keyword                     |
|                           | Syntax: important                     | 语法：重要         | --code-important                   |
|                           | Syntax: operators                     | 语法：运算符        | --code-operator                    |
|                           | Syntax: properties                    | 语法：属性         | --code-property                    |
|                           | Syntax: punctuation                   | 语法：标点         | --code-punctuation                 |
|                           | Syntax: strings                       | 语法：字符串        | --code-string                      |
|                           | Syntax: tags                          | 语法：标签         | --code-tag                         |
|                           | Syntax: values                        | 语法：值          | --code-value                       |
| Dataview                  | Trim Dataview columns                 | 裁剪Dataview列宽  | (无)                                |
|                           | Force table lists inline              | 强制表格列表行内显示    | (无)                                |
|                           | Dataview maximum column width         | Dataview最大列宽  | --max-col-width                    |
| Embeds and transclusions  | Use strict embed style globally       | 全局使用严格嵌入样式    | (无)                                |
|                           | Hide embed titles                     | 隐藏嵌入标题        | (无)                                |
|                           | Underline embedded text               | 下划线嵌入文本       | (无)                                |
|                           | Embedded text underline style         | 嵌入文本下划线样式     | --embed-decoration-style           |
|                           | Embedded text underline color         | 嵌入文本下划线颜色     | --embed-decoration-color           |
|                           | Embed background                      | 嵌入背景色         | --embed-background                 |
| Graphs                    | Node color                            | 节点颜色          | --graph-node                       |
|                           | Node color (active)                   | 节点颜色（激活）      | --graph-node-focused               |
|                           | Node color (tags)                     | 节点颜色（标签）      | --graph-node-tag                   |
|                           | Node color (attachments)              | 节点颜色（附件）      | --graph-node-attachment            |
|                           | Node color (unresolved)               | 节点颜色（未解析）     | --graph-node-unresolved            |
| Headings                  | Heading font                          | 标题字体 (H1-H6)  | --h1-font … --h6-font              |
|                           | Heading font size                     | 标题大小 (H1-H6)  | --h1 … --h6                        |
|                           | Heading font weight                   | 标题字重 (H1-H6)  | --h1-weight … --h6-weight          |
|                           | Heading font color                    | 标题颜色 (H1-H6)  | --h1-color … --h6-color            |
|                           | Heading font variant                  | 标题变体 (H1-H6)  | --h1-variant … --h6-variant        |
|                           | Heading font style                    | 标题风格 (H1-H6)  | --h1-style … --h6-style            |
|                           | Heading divider line                  | 标题分割线         | (无)                                |
| Icons                     | Icon opacity                          | 图标不透明度        | --icon-muted                       |
|                           | Icon color                            | 图标颜色          | --icon-color                       |
|                           | Icon color (hover)                    | 图标颜色（悬停）      | --icon-color-hover                 |
|                           | Icon color (active)                   | 图标颜色（激活）      | --icon-color-active                |
| Images                    | Image opacity in dark mode            | 暗色模式下图片不透明度   | --images-muted                     |
|                           | Disable image zoom                    | 禁用图片缩放        | (无)                                |
| Indentation Guides        | Horizontal adjustment in reading mode | 阅读模式水平调整      | --ig-adjust-reading                |
|                           | Horizontal adjustment in editing mode | 编辑模式水平调整      | --ig-adjust-edit                   |
|                           | Indentation guide color               | 缩进引导线颜色       | --indentation-guide-color          |
|                           | Indentation guide color (active)      | 缩进引导线颜色（激活）   | --indentation-guide-color-active   |
| Links                     | Internal link color                   | 内部链接颜色        | --link-color                       |
|                           | Internal link color (hover)           | 内部链接颜色（悬停）    | --link-color-hover                 |
|                           | Unresolved link opacity               | 未解析链接不透明度     | --link-unresolved-opacity          |
|                           | Unresolved link color                 | 未解析链接颜色       | --link-unresolved-color            |
|                           | Unresolved link underline color       | 未解析链接下划线颜色    | --link-unresolved-decoration-color |
|                           | External link color                   | 外部链接颜色        | --link-external-color              |
|                           | External link color (hover)           | 外部链接颜色（悬停）    | --link-external-color-hover        |
| Lists and checkboxes      | Checkbox color                        | 复选框颜色         | --checkbox-color                   |
|                           | Checkbox shape                        | 复选框形状         | (无)                                |
|                           | Strike completed tasks                | 删除线已完成任务      | (无)                                |
|                           | List item spacing                     | 列表项间距         | --list-spacing                     |
|                           | Nested list indentation               | 嵌套列表缩进        | --list-indent                      |
| Progress bars             | Completed progress bar color          | 已完成进度条颜色      | --progress-completed               |
| Properties                | Hide properties heading               | 隐藏属性标题        | (无)                                |
|                           | Hide "Add property" button            | 隐藏“添加属性”按钮    | (无)                                |
|                           | Hide property icons                   | 隐藏属性图标        | (无)                                |
|                           | Property row lines                    | 属性行分隔线        | (无)                                |
|                           | Property name width                   | 属性名称宽度        | --metadata-label-width             |
| Sidebars                  | Sidebar tab style                     | 侧边栏标签样式       | (无)                                |
|                           | Sidebar tab names                     | 侧边栏标签名称       | (无)                                |
|                           | Mobile left sidebar width             | 移动端左侧边栏宽度     | --mobile-left-sidebar-width        |
|                           | Mobile right sidebar width            | 移动端右侧边栏宽度     | --mobile-right-sidebar-width       |
| Tables                    | Table font size                       | 表格字体大小        | --table-font-size                  |
|                           | Maximize table width                  | 最大化表格宽度       | (无)                                |
|                           | Row lines                             | 行分隔线          | (无)                                |
|                           | Column lines                          | 列分隔线          | (无)                                |
|                           | Cell lines                            | 单元格分隔线        | (无)                                |
|                           | Striped rows                          | 条纹行           | (无)                                |
|                           | Striped columns                       | 条纹列           | (无)                                |
|                           | Tabular figures                       | 等宽数字          | (无)                                |
|                           | Row numbers                           | 行号            | (无)                                |
|                           | Disable line wrap                     | 禁用自动换行        | (无)                                |
|                           | Highlight active row                  | 高亮活动行         | (无)                                |
|                           | Active row background                 | 活动行背景色        | --row-color-hover                  |
| Tabs                      | Tab bar height                        | 标签栏高度         | --header-height                    |
|                           | Tab style                             | 标签样式          | (无)                                |
|                           | Tab text color                        | 标签文字颜色        | --minimal-tab-text-color           |
|                           | Tab text color (active)               | 标签文字颜色（激活）    | --minimal-tab-text-color-active    |
| Tab stacks                | Stacked width                         | 堆叠宽度          | --tab-stacked-pane-width           |
|                           | Spine width                           | 脊柱宽度          | --tab-stacked-header-width         |
|                           | Spine text orientation                | 脊柱文字方向        | (无)                                |
| Tags                      | Plain tags                            | 纯文本标签         | (无)                                |
|                           | Tag shape                             | 标签形状          | --tag-radius                       |
|                           | Tag border width                      | 标签边框宽度        | --tag-border-width                 |
|                           | Tag text color                        | 标签文字颜色        | --tag-color                        |
|                           | Tag background color                  | 标签背景色         | --tag-bg                           |
|                           | Tag background color (hover)          | 标签背景色（悬停）     | --tab-bg2                          |
| Text                      | Normal text color                     | 普通文字颜色        | --tx1                              |
|                           | Selected text background              | 选中文本背景        | --hl1                              |
|                           | Highlighted text background           | 高亮文本背景        | --hl2                              |
|                           | Muted text color                      | 低对比文字颜色       | --tx2                              |
|                           | Faint text color                      | 极淡文字颜色        | --tx3                              |
|                           | Italic text color                     | 斜体文字颜色        | --italic-color                     |
|                           | Bold text color                       | 粗体文字颜色        | --bold-color                       |
|                           | Bold text weight                      | 粗体字重调整        | --bold-modifier                    |
|                           | Paragraph spacing                     | 段落间距          | --spacing-p                        |
| Titles - Tab title bar    | Tab title visibility                  | 标签标题可见性       | (无)                                |
|                           | Tab title font size                   | 标签标题字体大小      | --file-header-font-size            |
|                           | Title font weight                     | 标题字重          | --file-header-font-weight          |
|                           | Tab title alignment                   | 标签标题对齐        | --file-header-justify              |
|                           | Tab title text color (active)         | 标签标题文字颜色（激活）  | --title-color                      |
|                           | Tab title text color (inactive)       | 标签标题文字颜色（非激活） | --title-color-inactive             |
| Titles - Inline title     | Inline title font                     | 行内标题字体        | --inline-title-font                |
|                           | Inline title font size                | 行内标题字体大小      | --inline-title-size                |
|                           | Inline title font weight              | 行内标题字重        | --inline-title-weight              |
|                           | Inline title text color (active)      | 行内标题文字颜色（激活）  | --inline-title-color               |
| Translucency              | Translucent background color          | 半透明背景色        | --workspace-background-translucent |
| Window frame              | Hide window frame title               | 隐藏窗口标题栏文字     | (无)                                |
|                           | Frame background                      | 框架背景色         | --frame-background                 |
|                           | Frame icon color                      | 框架图标颜色        | --frame-icon-color                 |
|                           | Frame title color (focused)           | 框架标题颜色（聚焦）    | --titlebar-text-color-focused      |
|                           | Frame title color (inactive)          | 框架标题颜色（非激活）   | --titlebar-text-color              |
|                           | Frame title font weight               | 框架标题字重        | --titlebar-text-weight             |
| Minimal Cards             | Card minimum width                    | 卡片最小宽度        | --cards-min-width                  |
|                           | Card maximum width                    | 卡片最大宽度        | --cards-max-width                  |
|                           | Card minimum width on mobile          | 移动端卡片最小宽度     | --cards-mobile-width               |
|                           | Card padding                          | 卡片内边距         | --cards-padding                    |
|                           | Card maximum image height             | 卡片最大图片高度      | --cards-image-height               |
|                           | Card border width                     | 卡片边框宽度        | --cards-border-width               |
|                           | Card background color                 | 卡片背景色         | --cards-background                 |
| Minimal Advanced Settings | Display window title                  | 显示窗口标题        | (无)                                |
|                           | Cursor style                          | 光标样式          | --cursor                           |
|                           | Smaller font size                     | 较小字体大小        | --font-smaller                     |
|                           | Smallest font size                    | 最小字体大小        | --font-smallest                    |

这些是目前Minimal主题在Style Settings中提供的全部可调选项（截至2026年1月）。如果你的Obsidian版本或Minimal版本更新，可能会有少量新增或调整，建议直接在插件中查看实际界面。





