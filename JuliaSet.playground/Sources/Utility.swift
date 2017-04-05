import UIKit

typealias Double3 = (Double, Double, Double)

struct RGBRange {
    var colorIn: Double3 = (0, 0, 0)
    var colorOut: Double3 = (0, 0, 0)
}

public struct JuliaSetColor {
    
    public var hue = 0.0
    public var brightness = 0.0
    public var saturation = 1.0
    
    public init(hue: Double, brightness: Double, saturation: Double) {
        self.hue = hue
        self.brightness = brightness
        self.saturation = saturation
    }
    
    func toRGBRange() -> RGBRange {
        //
        // This method converts hue and brightness to dynamic ranges
        // of RGB channels. The ranges will be used to coloring the
        // fractal image.
        //
        // The goal is to get better color and visual quality.
        //
        //  1.0          /----
        //              /
        //             /
        //            /
        //           /
        //  0.0 ----/
        //      0  in---out  1
        //
        //  (Between in and out, there is the dynamic range of the channel.)
        //
        
        var s = RGBRange()
        var hsb = HSBComponents()
        
        // out
        hsb.h = self.hue
        hsb.s = self.brightness / 10 + 0.65 * self.saturation
        hsb.b = 1 - self.brightness
        s.colorOut = hsb.toRGB().double3
        
        // in
        hsb.b = (1 - cos(hsb.b * .pi)) / 8  // not evil at all
        s.colorIn = hsb.toRGB().double3
        
        return s
    }
    
}

struct RGBComponents {
    
    var r = 0.0, g = 0.0, b = 0.0
    
    var double3: Double3 {
        return (r, g, b)
    }
    
    func toHSB() -> HSBComponents {
        return UIColor(rgb: self).hsb
    }
    
}

struct HSBComponents {
    
    var h = 0.0, s = 0.0, b = 0.0
    
    var double3: Double3 {
        return (h, s, b)
    }
    
    func toRGB() -> RGBComponents {
        return UIColor(hsb: self).rgb
    }
    
}

extension UIColor {
    
    convenience init(rgb: RGBComponents, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(rgb.r), green: CGFloat(rgb.g), blue: CGFloat(rgb.b), alpha: alpha)
    }
    
    convenience init(hsb: HSBComponents, alpha: CGFloat = 1.0) {
        self.init(hue: CGFloat(hsb.h), saturation: CGFloat(hsb.s), brightness: CGFloat(hsb.b), alpha: alpha)
    }
    
    var rgb: RGBComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return RGBComponents(r: Double(r), g: Double(g), b: Double(b))
    }
    
    var hsb: HSBComponents {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSBComponents(h: Double(h), s: Double(s), b: Double(b))
    }
    
}

func clamp<T>(_ value: T, _ minValue: T, _ maxValue: T) -> T where T: Comparable {
    return min(max(value, minValue), maxValue)
}

extension UInt32 {
    
    init(blue b: Double, green g: Double, red r: Double) {
        self = UInt32(255 * clamp(r, 0, 1))
        self |= UInt32(255 * clamp(g, 0, 1)) << 8
        self |= UInt32(255 * clamp(b, 0, 1)) << 16
    }
    
}
