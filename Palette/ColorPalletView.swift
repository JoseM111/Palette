import UIKit

class ColorPalletView: UIView {
    
    var colors: [UIColor] {
        didSet {
            buildColorBricks()
        }
    }
    
    // Every UIView has to be initialized with a frame
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    // It has to be able to incode & decode your views
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    // MARK: -Helper Methods
    /**©---------------------------------------------©*/
    func setupViews() {
        self.addSubview(colorStkView)
        colorStkView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBtm: 0, paddingLeading: 0, paddingTrailing: 0)
        
        self.layer.cornerRadius = (self.frame.height / 2)
        self.layer.masksToBounds = true
        
        
    }
    
    func buildColorBricks() {
        resetColorBricks()
        
        for color in colors {
            let colorBrick = generateColoredBricks(for: color)
            self.addSubview(colorBrick)
            self.colorStkView.addArrangedSubview(colorBrick)
        }
        // Relay out our stack view with the color bricks or other views
        self.layoutIfNeeded()
    }
    
    func generateColoredBricks(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    func resetColorBricks() {
        for subview in colorStkView.arrangedSubviews {
            self.colorStkView.removeArrangedSubview(subview)
        }
    }
    /**©---------------------------------------------©*/
    
    // MARK: -views
    /**©---------------------------------------------©*/
    let colorStkView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        
        return stackView
    }()
    /**©---------------------------------------------©*/
    
}// END OF CLASS
