import Foundation

fileprivate struct ByteFloat: ExpressibleByFloatLiteral {
    
    private var rawData: UInt8
    
    // 0 ... 1
    init(floatLiteral value: Double) {
        let v = min(max(0, value), 1)
        rawData = UInt8(Float(UInt8.max) * Float(v))
    }
    
    var floatValue: Float {
        let v = Float(rawData) / Float(UInt8.max)
        return v
    }
    
    var doubleValue: Double {
        return Double(self.floatValue)
    }
    
    var hexString: String {
        var s = String(rawData, radix: 16, uppercase: true)
        let cnt = s.count
        for _ in 0 ..< (2 - cnt) {
            s = "0" + s
        }
        return s
    }
    
    init?(hexString: String) {
        if let raw = UInt8(hexString, radix: 16) {
            self.rawData = raw
        } else {
            return nil
        }
    }
    
}

fileprivate struct JuliaFloat: ExpressibleByFloatLiteral {
    
    private var rawData: UInt16
    
    // -2.0 ... +2.0
    init(floatLiteral value: Double) {
        var v = min(max(-2.0, value), 2.0)
        v = (v + 2.0) / 4.0 // 0 ... 1
        rawData = UInt16(Float(UInt16.max) * Float(v))
    }
    
    var floatValue: Float {
        let v = Float(rawData) / Float(UInt16.max)
        return (v * 4.0) - 2.0
    }
    
    var hexString: String {
        var s = String(rawData, radix: 16, uppercase: true)
        let cnt = s.count
        for _ in 0 ..< (4 - cnt) {
            s = "0" + s
        }
        return s
    }
    
    init?(hexString: String) {
        if let raw = UInt16(hexString, radix: 16) {
            self.rawData = raw
        } else {
            return nil
        }
    }
    
}

extension Complex {
    
    fileprivate var hexString: String {
        let hex1 = JuliaFloat(floatLiteral: x)
        let hex2 = JuliaFloat(floatLiteral: y)
        return hex1.hexString + hex2.hexString
    }
    
    fileprivate static func make(hexString: String) -> Complex? {
        guard hexString.count == 8 else {
            return nil
        }
        let hex1 = hexString.prefix(4)
        let hex2 = hexString.suffix(4)
        if let hx = JuliaFloat(hexString: String(hex1)),
            let hy = JuliaFloat(hexString: String(hex2)) {
            return Complex(hx.floatValue, hy.floatValue)
        } else {
            return nil
        }
    }
    
}

extension JuliaSetColor {
    
    fileprivate var hexString: String {
        let hex1 = ByteFloat(floatLiteral: hue)
        let hex2 = ByteFloat(floatLiteral: brightness)
        let hex3 = ByteFloat(floatLiteral: saturation)
        return hex1.hexString + hex2.hexString + hex3.hexString
    }
    
    fileprivate static func make(hexString: String) -> JuliaSetColor? {
        guard hexString.count == 6 else {
            return nil
        }
        let hex1 = hexString.prefix(2)
        let hex2 = hexString.prefix(4)
        let hex3 = hexString.suffix(2)
        if let h = ByteFloat(hexString: String(hex1)),
            let b = ByteFloat(hexString: String(hex2.suffix(2))),
            let s = ByteFloat(hexString: String(hex3)) {
            return JuliaSetColor(hue: h.doubleValue, brightness: b.doubleValue, saturation: s.doubleValue)
        } else {
            return nil
        }
    }
    
}

extension JuliaSet {
    
    public func encodeURL() -> URL {
        return URL(string: "juliaset://?code=\(encodeHexString())")!
    }
    
    public static func decodeURL(_ url: URL) -> JuliaSet? {
        guard url.scheme == "juliaset" else {
            return nil
        }
        guard let code = url.parameters["code"] else {
            return nil
        }
        
        return JuliaSet.decode(hexString: code)
    }
    
    public static func decodeURL(_ urlString: String) -> JuliaSet? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return decodeURL(url)
    }
    
    func encodeHexString() -> String {
        let hex1 = const.hexString  // 8
        let hex2 = center.hexString  // 8
        let hex3 = encodeWindow().hexString  // 2
        let hex4 = color.hexString  // 6
        return hex1 + hex2 + hex3 + hex4
    }
    
    static func decode(hexString: String) -> JuliaSet? {
        guard hexString.count == 24 else {
            return nil
        }
        let hex1 = hexString.prefix(8)
        let hex2 = (hexString.prefix(16) as String.SubSequence).suffix(8)
        let hex3 = (hexString.suffix(8) as String.SubSequence).prefix(2)
        let hex4 = hexString.suffix(6)
        
        guard let const = Complex.make(hexString: String(hex1)) else {
            return nil
        }
        guard let center = Complex.make(hexString: String(hex2)) else {
            return nil
        }
        guard let window = ByteFloat(hexString: String(hex3)) else {
            return nil
        }
        guard let color = JuliaSetColor.make(hexString: String(hex4)) else {
            return nil
        }
        var s = JuliaSet()
        s.center = center
        s.const = const
        s.window = decodeWindow(window)
        s.color = color
        return s
    }
    
    private func encodeWindow() -> ByteFloat {
        let w = min(max(7e-5, self.window), 4.0)
        return ByteFloat(floatLiteral: (2 - log2(w)) / 16.0)
    }
    
    private static func decodeWindow(_ f: ByteFloat) -> Double {
        return pow(2, 2 - f.doubleValue * 16.0)
    }
    
}

extension URL {
    
    var parameters: [String: String] {
        guard let q = self.query else {
            return [:]
        }
        var result: [String: String] = [:]
        for seg in q.components(separatedBy: "&") {
            let pair = seg.components(separatedBy: "=")
            if pair.count != 2 {
                continue
            }
            if pair[0].isEmpty {
                continue
            }
            result[pair[0]] = pair[1]
        }
        return result
    }
    
}
