//
//  Other.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/14/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

extension Image: Decodable {

public init(from decoder: Decoder) throws {
    let values = try decoder.singleValueContainer()
    let name = try values.decode(String.self)
    print("Decoded Image: \(name)")
    self.init(name)
  }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

extension Color {

    func uiColor() -> UIColor {

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}

extension View {
    func isHidden(_ hidden: Bool) -> some View {
        modifier(HiddenModifier(isHidden: hidden))
    }
    
    func isBlur(_ blur: Bool) -> some View{
        modifier(BlurAnimation(isBlur: blur))
    }
    
    func gradientBackground() -> some View{
        LinearGradient(gradient:
            Gradient(colors: [Color("Dark"), Color("MedDark")]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    func wrapRoundRectangle(stroke: Color, fill: Color) -> some View{
        modifier(RoundRectangleModifier(stroke: stroke, fill: fill))
    }
    
    func fitImage(_ image: Image) -> some View{
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    func plainButtonStyle() -> some View{
        modifier(PlainButtonModifier())
    }
    
    func plainTextStyle() -> some View{
        modifier(PlainTextModifier())
    }
    
    func grayOut(_ isGrayOut: Bool) -> some View{
        modifier(GrayModifier(isGrayOut))
    }
    
    func fontSize(_ font: Int) -> some View{
        modifier(FontModifier(font))
    }
    
    func horizontalCenter() -> some View{
        modifier(CenterModifier())
    }
}

struct HiddenModifier: ViewModifier {

    private let isHidden: Bool

    init(isHidden: Bool) {
        self.isHidden = isHidden
    }

    func body(content: Content) -> some View {
        content
        .offset(x: 0, y: isHidden ? 1000 : 0)
//        .frame(width: isHidden ? 0 : 350)
    }
}

struct GrayModifier: ViewModifier {

    private let isGrayOut: Bool

    init(_ isGrayOut: Bool) {
        self.isGrayOut = isGrayOut
    }

    func body(content: Content) -> some View {
        content.colorMultiply(isGrayOut ? Color.gray : Color.white)
    }
}

struct BlurAnimation: ViewModifier {

    private let isBlur: Bool

    init(isBlur: Bool) {
        self.isBlur = isBlur
    }

    func body(content: Content) -> some View {

        content
        .animation(nil)
        .colorMultiply(isBlur ? .gray: .white)
        .blur(radius:isBlur ? 20 : 0)
        .animation(.default)
    }
}

struct RoundRectangleModifier: ViewModifier {
    
    private let stroke: Color
    private let fill: Color

    init(stroke: Color, fill: Color) {
        self.stroke = stroke
        self.fill = fill
    }

    func body(content: Content) -> some View {

        content
        .padding(3)
        .background(
            RoundedRectangle(cornerRadius: 16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                .stroke(stroke, lineWidth: 4)
            )
            .foregroundColor(fill)
        )
    }
}

struct PlainButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {

        content
        .buttonStyle(PlainButtonStyle())
        .colorMultiply(.secondary)
        .padding()
    }
}

struct  PlainTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {

        content
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
//            .padding(10.0)
    }
}

struct FontModifier: ViewModifier {
    
    private let font: CGFloat

    init(_ font : Int) {
        self.font = CGFloat(font)
    }

    func body(content: Content) -> some View {
        content.font(.system(size: font))
    }
}

struct CenterModifier: ViewModifier {

    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
