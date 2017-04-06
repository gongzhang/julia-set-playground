[>>> Jump to English Version <<<](https://github.com/gongzhang/julia-set-playground#julia-set-playground)

# 朱利亚集合 Playground

此项目是一个能够生成“*朱利亚集合*” *(Julia Set)* 分形图像的 **Swift Playground** 工程。*朱利亚集合* 是分形理论中的经典概念，它可以生成令人惊叹的分形图像。

*朱利亚集合* 的数学公式简单而优雅：

```
z(n+1) = z(n)^2 + c
```

...但它却能够产生出多样的、蕴含无线细节的美丽分形图像：

<img src="./Images/playground.png" width="600">

> Xcode 8.3 Playground 截图

想要了解关于 *朱利亚集合* 的更多知识，请参阅 [维基百科 Julia Set 中文条目](https://zh.wikipedia.org/wiki/%E6%9C%B1%E5%88%A9%E4%BA%9A%E9%9B%86%E5%90%88)。

## 关于此项目

我曾与江苏卫视 *最强大脑*（第四季）节目组合作，共同打造了一个以分形数学为主题的挑战题目。节目现场使用了本项目的提供的分形图生成技术。该期节目于 2017 年 2 月 10 日播出，可以在爱奇艺网站观看：[http://www.iqiyi.com/v_19rrapeyvc.html](http://www.iqiyi.com/v_19rrapeyvc.html)。

<img src="./Images/zqdn.jpeg" width="400">

> 江苏卫视「最强大脑」第四季，第 2017-2-10 期节目

此项目的核心技术也在我的个人 iOS 应用“*分形的奥秘*” *(Mysteries of Fractal)* 中使用。**强烈推荐给各位**，可以在 App Store 中免费下载这个应用：[App Store 链接](https://itunes.apple.com/app/apple-store/id1086527481?pt=117851333&ct=github&mt=8)。

<img src="./Images/appstore.png" width="300">

## 如何使用代码

下载 `JuliaSet.playground` 并使用最新版本的 *Xcode* 就可以编译运行。全部代码文件位于 `JuliaSet.playground/Sources` 目录下。

如果你有 iPad ，也可以在苹果的 *Swift Playgrounds* 应用中编译和运行本项目。

## API 使用样例

你可以**手动指定参数**并观察它们如何影响分形图的生成：

```swift
let imageSize = CGSize(width: 600, height: 440)
var julia = JuliaSet()

julia.window = 4.0
julia.const = Complex(-0.5, 0.0)
julia.color = JuliaSetColor(
    hue: 0,
    brightness: 0.87,
    saturation: 0.9
)

let outputImage = JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)
```

你也可以从 *分形的奥秘* 应用中**导出某个特定的分形图**，然后将它的代号放在 Playground 中绘制:

```swift
var code = "juliaset://?code=25477FFF7FFF7FEB5A4400FE"  // 从“分形的奥秘”中导出的一个分形
let outputImage = JuliaSetRenderer.syncRender(JuliaSet.decodeURL(code)!, pixelSize: imageSize)
```

渲染程序也支持**异步**渲染方法，它不会阻塞主线程。如果你准备在实际 iOS 项目中渲染分形图，这个方法就会很有用。

```swift
// 在后台渲染...
JuliaSetRenderer.asyncRender(julia, sizeInPixel: imageSize) { outputImage in
    // ...然后在主线程中获取结果
}
```

## 更多有趣的数学项目

- 二维图像 FFT: [fft2d-swift-playground](https://github.com/gongzhang/fft2d-swift-playground)
- 傅里叶级数展开: [swift-fourier-expansion](https://github.com/gongzhang/swift-fourier-expansion)
- 复数(虚数)运算: [swift-complex-number](https://github.com/gongzhang/swift-complex-number)

## 联系方式

- 领英: [linkedin.com/in/zhanggong](https://www.linkedin.com/in/zhanggong/)
- 邮件: [gong@me.com](mailto:gong@me.com)

***

> 以下为英文版本 README

# Julia Set Playground

This repo contains a **Swift Playground** that generates *Julia set* fractal images. *Julia set* is a classical concept in fractal mathematics, and it can be used to generate amazing fractal images.

The formula of *Julia set* is simple and elegant:

```
z(n+1) = z(n)^2 + c
```

...But it can generates varies beautiful fractal images with infinity details:

<img src="./Images/playground.png" width="600">

> Xcode 8.3 Playground Screenshot

For more information about *Julia set*, See [https://en.wikipedia.org/wiki/Julia_set](https://en.wikipedia.org/wiki/Julia_set).

This project is used in my iOS app *Mysteries of Fractal (分形的奥秘)*. You can download it in the App Store for free. [App Store Link](https://itunes.apple.com/app/apple-store/id1086527481?pt=117851333&ct=github&mt=8)

<img src="./Images/appstore.png" width="300">

## Installation

Just download `JuliaSet.playground` and open it by latest version of *Xcode*. All the code is in `JuliaSet.playground/Sources` folder.

If you have an iPad, you can also run this project using Apple's *Swift Playgrounds* app.

## Sample Code

You can **manually adjust the parameters** and see how they affect the image:

```swift
let imageSize = CGSize(width: 600, height: 440)
var julia = JuliaSet()

julia.window = 4.0
julia.const = Complex(-0.5, 0.0)
julia.color = JuliaSetColor(
    hue: 0,
    brightness: 0.87,
    saturation: 0.9
)

let outputImage = JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)
```

You can also **export a specific fractal** from the *Mysteries of Fractal* app, then draw it in playground:

```swift
var code = "juliaset://?code=25477FFF7FFF7FEB5A4400FE"  // exported by "Mysteries of Fractal" app
let outputImage = JuliaSetRenderer.syncRender(JuliaSet.decodeURL(code)!, pixelSize: imageSize)
```

The render also provides an *asynchronous* method to generate fractal image, which does not block the main thread. It's useful when you generate big image in a real iOS app.

```swift
// render in background...
JuliaSetRenderer.asyncRender(julia, sizeInPixel: imageSize) { outputImage in
    // ...then get result in main thread
}
```

## More Mathematics Playground Projects

- 2D Image FFT: https://github.com/gongzhang/fft2d-swift-playground
- Fourier Expansion: https://github.com/gongzhang/swift-fourier-expansion
- Complex Number: https://github.com/gongzhang/swift-complex-number

## Contact

Feel free to contact me if you need more information ;)

Email: *gong@me.com*
