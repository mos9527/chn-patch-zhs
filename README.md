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

### 参加人员
- [mos9527](https://github.com/mos9527)
- *(没了)*

### 文本进度
[→文件传送门](https://github.com/mos9527/chn-patch-zhs/tree/master/scripts/mes01)
| 内容 | 进度 | 翻译 | 校对 | 审核 |
| --- | --- | --- | --- | --- |
| 系统 | 100% | mos9527 | mos9527 | mos9527 |
| 序章 | 100% | mos9527 | mos9527 | mos9527 |

### CG进度
[→文件传送门](https://github.com/mos9527/chn-patch-zhs/tree/master/data/c0data)
| 内容 | 进度 | 翻译 | 校对 | 审核 |
| --- | --- | --- | --- | --- |
| UI | 100% | mos9527 | mos9527 | mos9527 |


## 感谢
- [霞鹜铭心宋(补丁所用默认字体)](https://github.com/lxgw/LxgwHeartSerif)
- https://github.com/CommitteeOfZero/chn-patch
- https://zh.moegirl.org.cn/混沌之脑

## 工具链接
- https://github.com/mos9527/mages-tools
- https://github.com/mos9527/MgsScriptTools
