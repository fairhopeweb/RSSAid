<h1 align=center>RSSAid</h1>

<p align=center>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/flutter-1.22.4-fe562e?style=flat-square"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/SdkVersion-21%2B-blue?style=flat-square"></a>
<img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square">
</p>

> RSSAid 是一个由 Flutter 构建的 [RSSHub](https://github.com/DIYgod/RSSHub) 的辅助 App，和 [RSSHub Radar](https://github.com/DIYgod/RSSHub-Radar) 类似，他可以帮助你快速发现和订阅网站的 RSS。此外，他还支持 RSSHub 的通用参数 (实现过滤、获取全文等功能)。
> [英文版本](README.md)

[Telegram 群](https://t.me/rssaid_group) | [Telegram 频道](https://t.me/rssaid)

<p float='left'>
<img src="screenshots/home.png"  width="375">
<img src="screenshots/config.png"  width="375">
<img src="screenshots/settings.png" width="375">
</p>

## 下载

下载最新版本 [RSSAid](https://github.com/lt94/RSSAid/releases)

订阅 [Telegram 频道](https://t.me/rssaid_group) 以获取更新信息。

## 打包

自行打包，请参考官方文档 [打包并发布 Android 应用](https://flutter.cn/docs/deployment/android)

## 功能

- [x] 检测适用于网页的 RSSHub 源 (几乎支持所有 RSSHub Radar 的规则)
- [x] 移动端 URL 适配 (自动展开、常见移动子域名适配)
- [x] 读取剪贴板 URL
- [x] 快速订阅
- [x] 自定义通用参数
- [x] 自定义 RSSHub 域名
- [x] 自动更新 RSSHub Radar 规则
- [x] 支持微博
- [x] 手动输入规则
- [x] 历史记录保存
- [x] rss+ 规则
- [x] fdroid
- [x] English version 


## 参与 Beta 测试

加入 [Telegram 群](https://t.me/rssaid_group) 以获得最新详情。


## 规则

RSSAid 和 [RSSHub Radar](https://github.com/DIYgod/RSSHub-Radar) 使用同一份 [规则](https://github.com/DIYgod/RSSHub/blob/master/assets/radar-rules.js)，且均支持自动更新。

[为 RSSHub Radar 和 RSSAid 提交新的规则](https://docs.rsshub.app/joinus/#ti-jiao-xin-de-rsshub-radar-gui-ze)

> 请注意，在 `target` 中使用 `document` 的规则并不适用 RSSAid。RSSAid 并不是一个浏览器插件，它只获取并分析网站的 URL。

> 一些网站的移动端和电脑端页面 URL 不同。由于 RSSHub Radar 的规则是适配电脑端的，在你发现 RSSAid 无法识别 RSSHub Radar 可以识别的网站时，可以尝试使用电脑端的 URL 并在 Telegram 向作者反馈。

## 支持 RSSAid

RSSAid 是采用 MIT 许可的开源项目，使用完全免费。

觉得不错的话，可以通过下列的方法来赞助 RSSAid 的开发.

### 周期性赞助

周期性赞助可以获得额外的回报，比如更快的 GitHub 响应或者你的名字会出现在 RSSAid 的 GitHub 仓库.

*   通过 [爱发电](https://afdian.net/@leetao) 赞助

*   给我们发邮件联系赞助事宜: leetao@email.cn

### 一次性赞助

我们通过以下方式接受赞助:

*   [支付宝](http://ww1.sinaimg.cn/large/006wYWbGly1fm10itkjb6j30aj0a9t8w.jpg)

*   [微信支付](http://ww1.sinaimg.cn/large/006wYWbGly1fm10jihygsj309r09tglw.jpg)

## 作者

RSSAid 由 Leetao 制作，在 **MIT 协议** 下开源。
