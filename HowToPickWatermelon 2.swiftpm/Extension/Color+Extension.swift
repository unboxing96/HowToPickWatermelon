//
//  ColorExtentsion.swift
//
//
//  Created by 김태현 on 2/26/24.
//

import Foundation
import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {

    static let buttonLightInner = Color(hex: "CAEACD")
    static let buttonLightOuter = Color(hex: "64C265")
    static let buttonMidInner = Color(hex: "85C585")
    static let buttonMidOuter = Color(hex: "2B5930")
    static let buttonDarkInner = Color(hex: "68A869")
    static let buttonDarkOuter = Color(hex: "2B5930")
    static let grayLight = Color(hex: "F1F1F1")
    static let grayMid = Color(hex: "D9D9D9")
    static let grayDark = Color(hex: "6F6F6F")
}
