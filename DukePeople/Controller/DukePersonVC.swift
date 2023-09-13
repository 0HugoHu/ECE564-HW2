//
//  DukePersonVC.swift
//  Hugo
//
//  Created by Hugooooo on 9/11/23.
//

import UIKit
import SwiftUI
import AVKit
import BackgroundRemoval

class DukePersonVC: UIViewController {
    // Properties to hold the data passed-in
    var firstName: String = ""
    var lastName: String = ""
    var descriptionText: String = ""
    var imageUrl: String = ""
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = firstName
        lastNameLabel.text = ""
        descriptionLabel.text = ""
        imageView.image = nil
        
        if let image = imageFromBase64(base64String: imageUrl) {
            do {
                let removalImage = try BackgroundRemoval.init().removeBackground(image: image)
                let gradientImageView = GradientImageView(image: Image(uiImage: removalImage), lName: lastName, desc: descriptionText)
            
                // Create a UIHostingController to wrap the SwiftUI view
                let hostingController = UIHostingController(rootView: gradientImageView)
                let hostedView = hostingController.view!
                hostedView.translatesAutoresizingMaskIntoConstraints = false
                gradientView.addSubview(hostedView)
                gradientView.backgroundColor = .clear
                

                // Add the hosting controller's view to your view controller's view hierarchy
                self.view.addSubview(hostingController.view)

                NSLayoutConstraint.activate([
                    hostedView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor),
                    hostedView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor),
                    hostedView.topAnchor.constraint(equalTo: gradientView.topAnchor),
                    hostedView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor)
                ])
                
                addChild(hostingController)
                hostingController.didMove(toParent: self)
            } catch {
                //TODO: Handle error
                print("Error removing background")
            }
        }
    }
    
    /*
     Converts a base64 string to a UIImage
     */
    func imageFromBase64(base64String: String) -> UIImage? {
        if let data = Data(base64Encoded: base64String) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    
}
