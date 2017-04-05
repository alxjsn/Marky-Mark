//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol BaseFontStylingRule : ItemStyling {

    var baseFont : UIFont? { get }
}

extension ItemStyling {

    func neededBaseFont() -> UIFont? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BaseFontStylingRule, styling.baseFont != nil {
                return styling.baseFont
            }
        }
        return nil
    }

    func neededFont() -> UIFont? {
        
        var font: UIFont? = neededBaseFont()

        if shouldFontBeBold() {
            font = font?.makeBold()
        }

        if shouldFontBeItalic() {
            font = font?.makeItalic()
        }

        if shouldFontBeBold() && shouldFontBeItalic() {
            font = font?.makeItalicBold()
        }

        if let textSize = neededTextSize() {

            font = font?.changeSize(textSize)
        }

        return font
    }
}

private extension UIFont {

    func makeBold() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) {
            return UIFont.init(descriptor: descriptor, size: self.pointSize)
        }

        return nil
    }

    func makeItalic() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic) {
            return UIFont.init(descriptor: descriptor, size: self.pointSize)
        }

        return nil
    }

    func makeItalicBold() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits([.traitItalic, .traitBold]) {
            return UIFont.init(descriptor: descriptor, size: self.pointSize)
        }

        return nil
    }

    func changeSize(_ size : CGFloat) -> UIFont {

        return UIFont.init(descriptor: self.fontDescriptor.withSize(size), size: size)
    }
}
