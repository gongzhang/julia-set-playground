# Julia Set Playground

This repo contains a Swift playground project that display *Julia set* fractal images. *Julia set* is a very famous concept in fractal mathematics. It can be used to generate amazing fractal images.

The iterative formula of *Julia set*:

```
z(n+1) = z(n)^2 + c   // Pretty simple :)
```

For more information about Julia set, See [https://en.wikipedia.org/wiki/Julia_set](https://en.wikipedia.org/wiki/Julia_set).

## Screenshot

![](https://github.com/gongzhang/julia-set-playground/blob/master/Images/playground.png)

This project is also used by my iOS app *Mysteries of Fractal*. ([AppStore Link](https://itunes.apple.com/app/id1086527481))

![](https://github.com/gongzhang/julia-set-playground/blob/master/Images/appstore.png)

## How To Use

Just download `JuliaSet.playground` and it can be opened by Xcode 7.3. All the rendering code is in the `JuliaSet.playground/Sources` folder. You can use the code as a library in your own project as well.

## Sample Code

```swift
// the size of image (in pixel)
let imageSize = CGSize(width: 600, height: 400)

// define a Julia set
var julia = JuliaSet()
julia.window = 4.0
julia.const = Complex(-0.5, 0.0)
julia.color = JuliaSetColor(hue: 0, brightness: 0.8)

// render in main thread
let image = JuliaSetRenderer.syncRender(julia, sizeInPixel: imageSize)

// or render in background...
JuliaSetRenderer.asyncRender(julia, sizeInPixel: imageSize) { image in
    // then get result in main thread
}
```

## Contact

Feel free to contact me if you need more information ;)

Email: *gong@me.com*
