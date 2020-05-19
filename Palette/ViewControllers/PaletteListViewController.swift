import UIKit

class PaletteListViewController: UIViewController {
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var photos: [UnsplashPhoto] = []
    // Contains all of our buttons
    var listOfBtns: [UIButton] {
        return [featureButton, randomButton, doubleRainbowButton]
    }
    
    override func loadView() {
        super.loadView()
        
        // Added-Subviews
        addAllSubViews()
        // Add Constraints to our stackview
        setupBtnStkViews()
        
        constraintTableView()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
         configureTableView()
        activateBtns()
        UnsplashService.shared.fetchFromUnsplash(for: .featured) { (unsplashPhotos) in
            DispatchQueue.main.async {
                guard let unsplashPhotos = unsplashPhotos else { return }
                self.photos = unsplashPhotos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    // MARK: _@HELPER-METHODS
    /**©---------------------------------------------©*/
    func addAllSubViews() {
        // Added-Subviews
        self.view.addSubview(featureButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(btnStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setupBtnStkViews() {
        // Add Constraints to our stackview
        btnStackView.addArrangedSubview(featureButton)
        btnStackView.addArrangedSubview(randomButton)
        btnStackView.addArrangedSubview(doubleRainbowButton)
        
        // MARK: _topAnchor
        btnStackView.topAnchor
            .constraint(equalTo: safeArea.topAnchor, constant: 8)
            .isActive = true
        // MARK: _leadingAnchor
        btnStackView.leadingAnchor
            .constraint(equalTo: safeArea.leadingAnchor, constant: 8)
            .isActive = true
        // MARK: _trailingAnchor
        btnStackView.trailingAnchor
            .constraint(equalTo: safeArea.trailingAnchor, constant: -8)
            .isActive = true
        
    }
    
    func constraintTableView() {
        paletteTableView.anchor(top: btnStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 0, paddingBtm: 0, paddingLeading: 0, paddingTrailing: 0)
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "photoCell")
    }
    
    @objc func selectBtn(sender: UIButton) {
         listOfBtns.forEach { $0.setTitleColor(.lightGray, for: .normal) }
         sender.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
        
        switch sender {
            case featureButton:
                searchForCategory(.featured)
            case randomButton:
                searchForCategory(.random)
            case doubleRainbowButton:
                searchForCategory(.doubleRainbow)
            default:
                searchForCategory(.featured)
        }
     }
     
     // Setup our @IBAction programmactially by creating a target for each button
     func activateBtns() {
         listOfBtns.forEach { $0.addTarget(self, action: #selector(selectBtn(sender:)), for: .touchUpInside) }
        featureButton.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
     }
    
    func searchForCategory(_ unsplashRoute: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (unsplashPhotos) in
            DispatchQueue.main.async {
                guard let unsplashPhotos = unsplashPhotos else { return }
                self.photos = unsplashPhotos
                self.paletteTableView.reloadData()
            }
        }
    }
    /**©---------------------------------------------©*/
    
    // MARK: _@featureButton
    /**©---------------------------------------------©*/
    let featureButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Features", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    
    // MARK: _@randomButton
    let randomButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Random", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    // MARK: _@doubleRainbowButton
    let doubleRainbowButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Double Rainbow", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    // MARK: -Views
    let btnStackView: UIStackView = {
        let stkView  = UIStackView()
        stkView.axis = .horizontal
        stkView.alignment = .fill
        stkView.distribution = .equalSpacing
        stkView.translatesAutoresizingMaskIntoConstraints = false
        
        return stkView
    }()
    /**©---------------------------------------------©*/
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
}// END OF CLASS

extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        typealias s = SpacingConst
        
        let imgViewSpace: CGFloat = (view.frame.width - (2 * s.outerHorizintalPadding))
        let outerVerticalPaddingSpace: CGFloat = (2 * s.outerVerticalPadding)
        
        let objBuffer: CGFloat = s.verticalObjBuffer
        let labelSpace: CGFloat = (2 * s.smallElementHeight)
        
        let colorPaletteViewSpace: CGFloat = s.mediumElementHeight
        let result = imgViewSpace + outerVerticalPaddingSpace + labelSpace + objBuffer + colorPaletteViewSpace
        
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PaletteTableViewCell
        
        let photo = photos[indexPath.row]
        cell.photo = photo
        
        return cell
    }
}
