//
//  MainVC.swift
//  nextAuth
//
//  Created by Ali Dhanani on 14/12/2020.
//

import UIKit

class MainVC: UIViewController {

    // Title Label
    let titleLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // Description Label
    let descLbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // Image Label
    let pictureImg: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showText() // Getting response from the site
        positionDesign() // Desiging the Layout
    }
    
    // Using Singleton function to get the response
    func showText() {
        // Using of the Singelton Function
        JSONData.shared.getAllData() { (responses) in
            // Using Async method as UI work on the main thread
            DispatchQueue.main.async {
                self.pictureImg.load(urlString: responses!.img) // Loading Image by URL
                self.titleLbl.text = responses?.title // Getting Title text
                self.descLbl.text = responses?.alt // Getting Desc text
            }
        }
    }
    
    // Function for desiging the UI by anchors and constraints
    func positionDesign() {
        
        // Adding the Label and Image to the parent view
        self.view.addSubview(pictureImg)
        self.view.addSubview(titleLbl)
        self.view.addSubview(descLbl)
        
        // Center
        pictureImg.center = self.view.center
        titleLbl.center = self.view.center
        descLbl.center = self.view.center
        
        // enable auto layout
        pictureImg.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        
        AnchorForImage()
        AnchorForTitleLabel()
        AnchorForDescLabel()
        
    }
    
    func AnchorForImage() {
        //Image
        pictureImg.heightAnchor.constraint(equalToConstant: 200).isActive = true // height 200
        pictureImg.widthAnchor.constraint(equalToConstant: 200).isActive = true // Width 200
        pictureImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Screen Center
        pictureImg.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true // Screen center from y access with -100 meaning moving a little to the top
    }
    
    func  AnchorForTitleLabel() {
        //label title
        titleLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true // height 20
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true // making distance of 5 from the left screen
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true // making distance of 5 from the right screen
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // making it screen center by x axis
        titleLbl.topAnchor.constraint(equalTo: pictureImg.bottomAnchor, constant: 8).isActive = true // having adistance of 8 from the imageView
    }
    
    func AnchorForDescLabel() {
        // label desc
        descLbl.heightAnchor.constraint(equalToConstant: 130).isActive = true // Height to be 130
        descLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true // making distance of 5 from the left screen
        descLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true // making distance of 5 from the right screen
        descLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // making it screen center by x axis
        descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 8).isActive = true // having adistance of 8 from the title label
    }


}

// Making function for imageview to load image from page
extension UIImageView {
    
    // Load directly by URL
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
