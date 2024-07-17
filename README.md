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
| 内容 | 进度 | 
| --- | --- |
| 系统 | 100% | 
| 序章 | 100% | 
后续章节将随个人游玩进度更新；以下简要介绍翻译手段
- LLM: Claude 3.5 Sonnet
- System Prompt:
```
你是一名日译中翻译员；你将会不加说明，直接将*且只将*提供的*日语*部分翻译为中文
你的输出应只有文本，不包括任何其他内容
*注意*：元信息（如3700:[margin top="228"],Dialogue: 0,0:03:10.82,0:03:20.20,...，及控制符,如：[linebreak], [%p]）需要保留。
*注意*：注音（如[ruby-base]西條[ruby-text-start]にしじょう[ruby-text-end][ruby-base]中，にしじょう）需转换为罗马音（如nishijo）
*提示*: 你所翻译的文本来自《CHAOS;HEAD NOAH》游戏脚本。**保证**输出内容在格式上兼容
*提示*: 一些约定俗成的翻译如下：
その目だれの目？ -> 那视线是谁的视线
ギガロマニアックス -> GIGA-LO-MANIAC (词源来自 megalomaniac，世界观内指可以把妄想成现实的人)
リアルブート -> REAL BOOT (透过盲点让周围的人认知妄想，把这妄想变成现实)
ディソード -> DI-SWORD
将軍 -> 将军
*提示*: 翻译以准确性为原则以方便后期人工校对
```
### CG进度
[→文件传送门](https://github.com/mos9527/chn-patch-zhs/tree/master/data/c0data)
| 内容 | 进度 |
| --- | --- |
| UI | 100% |


## 感谢
- [霞鹜铭心宋(补丁所用默认字体)](https://github.com/lxgw/LxgwHeartSerif)
- https://github.com/CommitteeOfZero/chn-patch
- https://zh.moegirl.org.cn/混沌之脑

## 工具链接
- https://github.com/mos9527/mages-tools
- https://github.com/mos9527/MgsScriptTools
