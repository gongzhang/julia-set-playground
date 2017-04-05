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

This project is used in my iOS app *Mysteries of Fractal (分形的奥秘)*. You can download it in the App Store for free. [AppStore Link](https://itunes.apple.com/app/apple-store/id1086527481?pt=117851333&ct=github&mt=8)

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
