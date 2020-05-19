import UIKit

class PaletteTableViewCell: UITableViewCell {

    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Has to be called first
        addAllSubViews()
        // Call second
        constrainImgView()
        // Call third
        constrainTitleLabel()
        constrainColorPalleteView()
    }
    
    func updateViews() {
        guard let photo = photo else { return }
        fetchAndSetTheImage(for: photo)
        fetchAndSetColorSTack(for: photo)
        paletteTitleLabel.text = photo.description ?? "NO DESCRIPTION AVAILABLE"
    }
    
    func fetchAndSetTheImage(for unsplashPhoto: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: unsplashPhoto) { (image) in
            DispatchQueue.main.async {
                self.paletteImgView.image = image
            }
        }
    }
    
    func fetchAndSetColorSTack(for unsplashPhoto: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: unsplashPhoto.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    // MARK: -Subviews
    func addAllSubViews() {
        self.addSubview(paletteImgView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func constrainImgView() {
        typealias s = SpacingConst
        let imgViewWidth = self.contentView.frame.width - (2 * s.outerHorizintalPadding)
        
        paletteImgView.anchor(top: self.contentView.topAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: s.outerVerticalPadding, paddingBtm: 0, paddingLeading: s.outerHorizintalPadding, paddingTrailing: s.outerHorizintalPadding, width:  imgViewWidth, height: imgViewWidth)
    }
    
    func constrainTitleLabel() {
        typealias s = SpacingConst
        
        paletteTitleLabel.anchor(top: paletteImgView.bottomAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: s.verticalObjBuffer, paddingBtm: 0, paddingLeading: s.outerHorizintalPadding, paddingTrailing: s.smallElementHeight, width: nil, height: s.smallElementHeight)
    }
    
    func constrainColorPalleteView() {
        typealias s = SpacingConst
        
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: s.verticalObjBuffer, paddingBtm: 0, paddingLeading: s.outerHorizintalPadding, paddingTrailing: s.outerHorizintalPadding, width: nil, height: s.mediumElementHeight)
    }
    
    // MARK: -views
    /**©---------------------------------------------©*/
    let paletteImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .red
        
        return imgView
    }()
    
    let paletteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Alias-The-Great"
        label.textAlignment = .center
        return label
    }()
    
    let colorPaletteView: ColorPalletView = {
        let palleteView = ColorPalletView()
        
        return palleteView
    }()
    /**©---------------------------------------------©*/
}// END OF CLASS
