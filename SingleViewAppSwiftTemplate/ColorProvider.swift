//
//  ColorProvider.swift
//  TrueFalseStarter
//
//  Created by Bryan Richardson on 8/6/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
// simple struct copied from a prior project to change some colors around

enum ColorNames: String {
    case White, Teal, Yellow, Red, Orange, Dark, Purple, Green, Black
}
struct ColorProvider {
    let colors:[ColorNames: UIColor] = [
        .White: UIColor(red: 1, green: 1, blue: 1, alpha: 1), // white
        .Teal: UIColor(red: 49/255.0, green: 115/255.0, blue: 145/255.0, alpha: 1.0), // teal
        .Yellow: UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), // yellow
        .Red: UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), // red
        .Orange: UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), // orange
        .Dark: UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), // dark
        .Purple: UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), // purple
        .Green: UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), // green
        .Black: UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    ]

    func getUIColor(for color: ColorNames) -> UIColor {
        return colors[color]!
    }
    
}
