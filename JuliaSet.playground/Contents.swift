import UIKit

let imageSize = CGSize(width: 600, height: 440)
var julia = JuliaSet()


// Sample 1

julia.window = 4.0
julia.const = Complex(-0.5, 0.0)
julia.color = JuliaSetColor(hue: 0, brightness: 0.87, saturation: 0.9)

JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)

// Sample 2

julia.const = Complex(0.2, -0.5)
julia.color.hue = 0.75
julia.window = 4.5

JuliaSetRenderer.syncRender(julia, pixelSize: imageSize)

// Sample 3
// You can also export a specific fractal from the iOS app:
//   https://itunes.apple.com/app/apple-store/id1086527481?pt=117851333&ct=github&mt=8

var code = "juliaset://?code=25477FFF7FFF7FEB5A4400FE"
JuliaSetRenderer.syncRender(JuliaSet.decodeURL(code)!, pixelSize: imageSize)

// Sample 4

code = "juliaset://?code=17F87FFF7FFF7FFF329A7CFF"
JuliaSetRenderer.syncRender(JuliaSet.decodeURL(code)!, pixelSize: imageSize)
