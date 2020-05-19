import UIKit.UIView

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat, paddingBtm: CGFloat,
                paddingLeading: CGFloat, paddingTrailing: CGFloat,
                width: CGFloat? = nil, height: CGFloat? = nil) {
        
        // Dont have to add this function to all our views now
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBtm).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

struct SpacingConst {
    static let outerHorizintalPadding: CGFloat = 32.0
    static let outerVerticalPadding: CGFloat = 16.0
    static let verticalObjBuffer: CGFloat = 8.0
    static let smallElementHeight: CGFloat = 24.0
    static let mediumElementHeight: CGFloat = 32.0
}
