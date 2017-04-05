import UIKit

let imageSize = CGSize(width: 600, height: 400)
var julia = JuliaSet()


// Sample 1

julia.window = 4.0
julia.const = Complex(-0.5, 0.0)
julia.color = JuliaSetColor(hue: 0, brightness: 0.8, saturation: 0.9)

julia.encodeHexString()

JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)

// Sample 2

julia.const = Complex(-0.5, 0.618)
julia.color.hue = 0.5

JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)

// Sample 3

julia.const = Complex(0.2, -0.5)
julia.color.hue = 0.75

JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)
