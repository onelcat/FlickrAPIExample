

# 项目说明

运用MVC构建项目。

## 运行项目

1. 如果是从github clone项目。

```sh
$ git clone https://github.com/onelcat/FlickrAPIExample.git
$ cd  FlickrAPIExample
$ carthage update --platform iOS
```

2. 配置你自己的开发者账号。

3. 运行项目。

**注意: 这个网络项目在国内使用需要翻墙。可以使用VPN,SSR。如果需要账号请联系我。**

## 未完成部分

1. 一些用户错误提示未完成。
2. 延迟加载下一页数据。
3. 显示图片信息的时候，需要显示原始数据这部分没有完成，只是显示的一个高清图。
4. 原始数据GIF格式未完成。

## 优化部分

1. 完成错误提示。
2. 网络请求类。这个部分可以模仿`Alamofire`。
3. 图片下载管理类。这个部分可以模仿`Kingfisher`。图片已经下载完成的进行缓存,后台线程下载。
4. 显示图片信息的时候，点击图片后可以`show`原始图片界面。
5. GIF图片显示支持。

## 第三方依赖说明

- IGListKit: 是 `Instagram` 推出的新的 `UICollectionView` 框架，使用数据驱动，旨在创造一个更快更灵活的列表控件
- Alamofire: 网络请求
- Kingfisher: 网络图片下载，以及网络图片缓存
- ObjectMapper: json字符串解析

这个项目工程下面有3个APP。每一个APP用到的裤有差别。并且对比3个APP之间的差距。

1. FlickrAPIExample APP: 会用到`IGListKit`,`Alamofire`,`Kingfisher`,`Kingfisher`,`ObjectMapper`第三方的裤。

2. FlickrDemo: 只用到`ObjectMapper`裤。会在主界面出现图片渲染混乱的错误。网络请求，图片下载管理自己实现。

3. FlickrDemo1: 会用到`Alamofire`,`Kingfisher`,`Kingfisher`,`ObjectMapper`裤。


## 开发中遇到的问题

1. 开发过程中会出现前一天的日期无效的问题。
2. 自己定义图片框架，在使用中渲染cell的时候出现图片cell复用混乱的问题。
