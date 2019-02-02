//
//  Theme.swift
//  CounterList
//
//  Created by Aldo Antonio Martinez Avalos on 2/1/19.
//  Copyright © 2019 Cornershop. All rights reserved.
//

import UIKit

public protocol ThemeProtocol {
    var fonts: ThemeFontProtocol { get }
    var fontSizes: ThemeFontSizesProtocol { get }
    var colors: ThemeColors { get }
}

public protocol ThemeColors {
    var pallete: PalleteColors { get }
}

public protocol PalleteColors {
    var primary: UIColor { get }
    var actionLink: UIColor { get }
    
    var title: UIColor { get }
    var paragraph: UIColor { get }
    var label: UIColor { get }
    var button: UIColor { get }
}

public protocol ThemeFontProtocol {
    var regular: String { get }
    var bold: String { get }
}

public protocol ThemeFontSizesProtocol {
    var label: CGFloat { get }
    
    var paragraphLarge: CGFloat { get }
    var paragraphSmall: CGFloat { get }
}

public struct AppTheme: ThemeProtocol {
    public let fonts: ThemeFontProtocol = AppFonts()
    public let colors: ThemeColors = AppColors()
    public let fontSizes: ThemeFontSizesProtocol = AppFontSizes()
}

public struct AppFonts: ThemeFontProtocol {
    public let regular: String = "HelveticaNeue-Medium"
    public let bold: String = "HelveticaNeue-Bold"
}

public struct AppFontSizes: ThemeFontSizesProtocol {
    public let label: CGFloat = 15.0
    public let paragraphLarge: CGFloat = 15.0
    public let paragraphSmall: CGFloat = 12.0
}

public struct AppPallete: PalleteColors {
    public let primary: UIColor = UIColor.black
    public let actionLink: UIColor = UIColor.black
    
    public let title: UIColor = UIColor.black
    public let paragraph: UIColor = UIColor.black
    public let label: UIColor = UIColor.black
    public let button: UIColor = UIColor.black
}

public struct AppColors: ThemeColors {
    public let pallete: PalleteColors = AppPallete()
}

public struct Theme {
    public static let appTheme: ThemeProtocol = AppTheme()
}
