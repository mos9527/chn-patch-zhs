# CHAOS;HEAD NOAH Patch 简中计划
原项目：https://github.com/CommitteeOfZero/chn-patch

## Features
- (CoZ) 全新文字渲染系统（描边，自定义字体...）
    - 详见 https://sonome.dareno.me/projects/chn-patch.html
- 简中翻译
    - 详见 [翻译进度](#翻译进度)

## 本地构建
需要 Python3.6+ 环境与 Git
```powershell
git clone https://github.com/mos9527/chn-patch-zhs
cd chn-patch-zhs
```
使用例
- 查看帮助
`./build.ps1 --help`
- 构建
`./build.ps1`
- 构建（不更新依赖）
`./build.ps1 --no-update`
- 构建（不更新依赖，并安装到游戏目录）
`.\build.ps1 --no-update --game-path="C:\Program Files (x86)\Steam\steamapps\common\CHAOS;HEAD NOAH"`

## 直接安装
**注：** 安装前请将（若存在）已有的`HEAD NOAH`, `LanguageBarrier`文件夹删除（否则字库缓存可能过期）
在 [Release](https://github.com/mos9527/chn-patch-zhs/releases) 页面下载最新版本的 `Release.zip`，解压到游戏目录即可。

## 翻译进度
**注:** 文本源来自官方**日语**脚本，CG源来自官方**日语**脚本
### 文本
初步中文脚本由日语脚本经[ollama_translate.py](https://github.com/mos9527/chn-patch-zhs/blob/master/scripts/ollama_translate.py)完成，使用模型及参数为：
| 模型 | 参数 |
| --- | --- |
| SakuraLLM/Sakura-7B-Qwen2.5-v1.0-GGUF | {'temperature': 0.1, 'top_p': 0.3, 'max_tokens': 512,'frequency_penalty':0.1} |

对文本LLM翻译已完全进行。
### CG
暂无相关计划

## 校对进度
### 文本
TBD
### CG
TBD
### 参加人员
- [mos9527](https://github.com/mos9527)
- *(没了)*

### 贡献翻译
#### 准备工作
- 你需要 [Poedit](https://poedit.net/) 或其他软件来编辑 `.po` 文件

    [→文件传送门](https://github.com/mos9527/chn-patch-zhs/tree/master/scripts/zhs)
    
    这些文件即作品的翻译文本，你可以通过编辑这些文件来参与翻译。

    **注：** 源语言为官方**日语**脚本；未翻译部分为官方**英语**脚本，已翻译部分为中文文本。

- 你需要 [Photoshop](https://www.adobe.com/products/photoshop.html) 或其他软件来编辑 `.psd` 文件
    
    [→文件传送门](https://github.com/mos9527/chn-patch-zhs/tree/master/data/c0data)

    这些文件即作品的图片文本；注意现存图片并不一定包含全部待翻译CG。

- 在本地完成你的修改后即可提交更改；参考 [GitHub PR 的提交流程](https://docs.github.com/cn/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)


## 感谢
- [霞鹜铭心宋(补丁所用默认字体)](https://github.com/lxgw/LxgwHeartSerif)
- https://github.com/CommitteeOfZero/chn-patch
- https://zh.moegirl.org.cn/混沌之脑

## 工具链接
- https://github.com/mos9527/mages-tools
- https://github.com/mos9527/MgsScriptTools
