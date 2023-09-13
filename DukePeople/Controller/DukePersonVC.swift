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

/*
 This protocol is used to pass data back to the MainVC
 */
protocol DukePersonVCDelegate: AnyObject {
    func didEncounterError(errorMessage: String)
}


class DukePersonVC: UIViewController, GradientImageViewDelegate {
    // Properties to hold the data passed-in
    var firstName: String = ""
    var lastName: String = ""
    var descriptionText: String = ""
    var imageUrl: String = ""
    
    weak var delegate: DukePersonVCDelegate?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        firstNameLabel.text = firstName
        lastNameLabel.text = ""
        descriptionLabel.text = ""
        imageView.image = nil
        
        // Try to convert the base64 string to an image
        var image = imageFromBase64(base64String: imageUrl)
        if image == nil {
            image = UIImage(named: "UnknownPeople")!
        }

        do {
            let removalImage = try BackgroundRemoval.init().removeBackground(image: image!)
            var gradientImageView = GradientImageView(image: Image(uiImage: removalImage), lName: lastName, desc: descriptionText)
            gradientImageView.delegate = self
            
            // Create a UIHostingController to wrap the SwiftUI view
            let hostingController = UIHostingController(rootView: gradientImageView)
            self.present(hostingController, animated: true, completion: nil)
            let hostedView = hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            gradientView.addSubview(hostedView)
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
            delegate?.didEncounterError(errorMessage: "Error removing background")
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
    
    
    /*
     Handle back button evnet
     */
    @objc func back(_ sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     Handle the event when the back button is tapped
     */
    func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}
