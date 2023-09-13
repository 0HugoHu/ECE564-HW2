//
//  ViewController.swift
//  DukePeople
//
//  Created by Hugooooo on 8/31/23.
//

import UIKit
import Foundation

class ViewController: UIViewController, DukePersonVCDelegate {
    var validInput = true
    var errorString : String? = nil
    
    /*
     Callback for DukePersonVCDelegate error message
     */
    func didEncounterError(errorMessage: String) {
        validInput = true
        errorString = errorMessage
    }
    
    let inputFieldDUID = UITextField()
    let inputFieldParam = UITextField()
    let statusTextLabel = UILabel()
    let statusLabel = UILabel()
    let addButton = UIButton()
    let updateButton = UIButton()
    let deleteButton = UIButton()
    let findButton = UIButton()
    let listButton = UIButton()
    let helpButton = UIButton()
    let outputView = UITextView()
    let scrollView = UIScrollView()
    
    var dataModel: DukePersonDict!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sandboxURL: URL = getDocumentsDirectory()
        let JSONName = "dukePersonDict.json"
        dataModel = DukePersonDict(url: sandboxURL.appendingPathComponent(JSONName))
        
        // Fixed layout parameters
        let marginLeft = 16, marginRight = 16, marginTop = 32, marginBaseTop = 64
        let width = 390
        let width_100 = width - marginLeft - marginRight
        let width_50 = (width - marginLeft - marginRight) / 2 - marginRight / 2
        let width_25 = (width - marginLeft - 2 * marginRight) / 4 - marginRight / 2
        let heightInput = 50, heightLabel = 50, heightButton = 50, heightOutput = 370
        
        let cornerRadius : CGFloat = 10
        let fontFamily = "Courier"
        let fontSize : CGFloat = 16
        let inputAlpha : CGFloat = 1.0
        let outputAlpha : CGFloat = 0.8
        
        
        let view = self.view!
        view.backgroundColor = baseBackgroundColor
        
        inputFieldDUID.frame = CGRect(x: marginLeft, y: marginBaseTop + marginTop, width: width_100, height: heightInput)
        inputFieldDUID.font = UIFont(name: fontFamily, size: fontSize)
        inputFieldDUID.backgroundColor = inputBackgroundColor
        inputFieldDUID.layer.cornerRadius = cornerRadius
        inputFieldDUID.alpha = inputAlpha
        inputFieldDUID.textAlignment = .center
        inputFieldDUID.placeholder = "DUID"
        view.addSubview(inputFieldDUID)
        
        inputFieldParam.frame = CGRect(x: marginLeft, y: marginBaseTop + marginTop + heightInput + marginLeft, width: width_100, height: heightInput)
        inputFieldParam.font = UIFont(name: fontFamily, size: fontSize)
        inputFieldParam.backgroundColor = inputBackgroundColor
        inputFieldParam.layer.cornerRadius = cornerRadius
        inputFieldParam.alpha = inputAlpha
        inputFieldParam.textAlignment = .center
        inputFieldParam.placeholder = "Parameter"
        inputFieldParam.autocapitalizationType = UITextAutocapitalizationType.none
        inputFieldParam.autocorrectionType = .no
        view.addSubview(inputFieldParam)
        
        statusTextLabel.frame = CGRect(x: marginLeft, y: marginBaseTop + marginTop + 2 * heightInput + 2 * marginLeft, width:width_25, height: heightLabel)
        statusTextLabel.text = "Status: "
        statusTextLabel.textColor = normalColor
        statusTextLabel.font = UIFont(name: fontFamily, size: fontSize)
        view.addSubview(statusTextLabel)
        
        statusLabel.frame = CGRect(x: marginLeft + width_25 + marginLeft, y: marginBaseTop + marginTop + 2 * heightInput + 2 * marginLeft, width:width_100, height: heightLabel)
        statusLabel.text = "Wait for input..."
        statusLabel.textColor = statusLabelColorBlack
        statusLabel.font = UIFont(name: fontFamily, size: fontSize)
        view.addSubview(statusLabel)
        
        
        addButton.frame = CGRect(x: marginLeft, y: marginBaseTop + marginTop + 2 * heightInput + 3 * marginLeft + heightLabel, width:width_25, height: heightButton)
        addButton.backgroundColor = buttonBackgroundColorFocused
        addButton.layer.cornerRadius = cornerRadius
        addButton.titleLabel?.numberOfLines = 0
        addButton.titleLabel?.textAlignment = .center
        addButton.titleLabel?.lineBreakMode = .byWordWrapping
        addButton.setTitle("Add", for: UIControl.State())
        addButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        addButton.setTitleColor(normalColor, for: .normal)
        addButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(addButton)
        
        updateButton.frame = CGRect(x: 2 * marginLeft + width_25, y: marginBaseTop + marginTop + 2 * heightInput + 3 * marginLeft + heightLabel, width:width_25, height: heightButton)
        updateButton.backgroundColor = buttonBackgroundColorFocused
        updateButton.layer.cornerRadius = cornerRadius
        updateButton.titleLabel?.numberOfLines = 0
        updateButton.titleLabel?.textAlignment = .center
        updateButton.titleLabel?.lineBreakMode = .byWordWrapping
        updateButton.setTitle("Update", for: UIControl.State())
        updateButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        updateButton.setTitleColor(normalColor, for: .normal)
        updateButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(updateButton)
        
        deleteButton.frame = CGRect(x: 3 * marginLeft + 2 * width_25, y: marginBaseTop + marginTop + 2 * heightInput + 3 * marginLeft + heightLabel, width:width_25, height: heightButton)
        deleteButton.backgroundColor = buttonBackgroundColorFocused
        deleteButton.layer.cornerRadius = cornerRadius
        deleteButton.titleLabel?.numberOfLines = 0
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.titleLabel?.lineBreakMode = .byWordWrapping
        deleteButton.setTitle("Delete", for: UIControl.State())
        deleteButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        deleteButton.setTitleColor(normalColor, for: .normal)
        deleteButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(deleteButton)
        
        findButton.frame = CGRect(x: 4 * marginLeft + 3 * width_25, y: marginBaseTop + marginTop + 2 * heightInput + 3 * marginLeft + heightLabel, width:width_25, height: heightButton)
        findButton.backgroundColor = buttonBackgroundColorFocused
        findButton.layer.cornerRadius = cornerRadius
        findButton.titleLabel?.numberOfLines = 0
        findButton.titleLabel?.textAlignment = .center
        findButton.titleLabel?.lineBreakMode = .byWordWrapping
        findButton.setTitle("Find", for: UIControl.State())
        findButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        findButton.setTitleColor(normalColor, for: .normal)
        findButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(findButton)
        
        listButton.frame = CGRect(x: marginLeft, y: marginBaseTop + marginTop + 2 * heightInput + 4 * marginLeft + heightLabel + heightButton, width:width_50, height: heightButton)
        listButton.backgroundColor = buttonBackgroundColor
        listButton.layer.cornerRadius = cornerRadius
        listButton.titleLabel?.numberOfLines = 0
        listButton.titleLabel?.textAlignment = .center
        listButton.titleLabel?.lineBreakMode = .byWordWrapping
        listButton.setTitle("List All", for: UIControl.State())
        listButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        listButton.setTitleColor(normalColor, for: .normal)
        listButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(listButton)
        
        helpButton.frame = CGRect(x: 2 * marginLeft + width_50, y: marginBaseTop + marginTop + 2 * heightInput + 4 * marginLeft + heightLabel + heightButton, width:width_50, height: heightButton)
        helpButton.backgroundColor = buttonBackgroundColor
        helpButton.layer.cornerRadius = cornerRadius
        helpButton.titleLabel?.numberOfLines = 0
        helpButton.titleLabel?.textAlignment = .center
        helpButton.titleLabel?.lineBreakMode = .byWordWrapping
        helpButton.setTitle("Help", for: UIControl.State())
        helpButton.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        helpButton.setTitleColor(normalColor, for: .normal)
        helpButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(helpButton)
        
        
        scrollView.frame = CGRect(x: marginLeft, y: marginBaseTop + 2 * marginTop + 2 * heightInput + 4 * marginLeft + heightLabel + 2 * heightButton, width:width_100, height: heightOutput)
        scrollView.contentSize = CGSize(width: width_100, height: heightOutput)
        scrollView.addSubview(outputView)
        outputView.frame = CGRect(x: 0, y: 0, width: width_100, height: heightOutput)
        outputView.backgroundColor = outputBackgroundColor
        outputView.layer.cornerRadius = cornerRadius
        outputView.alpha = outputAlpha
        outputView.text = "This is a scroll view.\n\n"
        view.addSubview(scrollView)
    }
    
    
    /*
     Handle button press events
     */
    @objc func buttonPressed(_ sender: AnyObject){
        var outputViewInfo = outputView.text
        var buttonPressed = ""
        var enteredDUID : Int = 0
        var enteredPerson : DukePerson = DukePerson(DUID: 0, fName: "", lName: "", email: "", from: "", gender: .Unknown, role: .Unknown)
        var findUUID = false
        validInput = true
        errorString = nil
        
        // Get button event
        if let label = sender.titleLabel {
            if let text = label?.text {
                buttonPressed = text
            } else {return}
        } else {return}
        
        // Check for DUID
        if buttonPressed == "Add" || buttonPressed == "Update" || buttonPressed == "Delete" || buttonPressed == "Find" {
            if let DUIDString = inputFieldDUID.text {
                if let DUID = Int(DUIDString) {
                    enteredDUID = DUID
                } else {
                    validInput = false
                    errorString = "Invalid DUID!"
                }
            }
        }
        
        // Check for parameters
        if buttonPressed == "Find" && validInput {
            // Condition for only finding DUID
            findUUID = true
        } else if buttonPressed == "Add" || buttonPressed == "Update" || buttonPressed == "Find"{
            if (buttonPressed == "Find") {
                // Condition for only finding parameters
                validInput = true
            }
            if let paramString = inputFieldParam.text {
                if let temp = parseInputString(paramString, enteredDUID, buttonPressed) {
                    enteredPerson = temp
                } else {
                    validInput = false
                    errorString = "Invalid parameters!"
                }
            }
        }
        
        // Print current time
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        outputViewInfo! += dateFormatter.string(from: currentDate) + "\n"
        
        // Data model operations
        if validInput {
            switch buttonPressed {
            case "Add":
                if dataModel.add(enteredPerson) {
                    outputViewInfo! += "Added person: \(enteredDUID) succeeded.\n"
                } else {
                    validInput = false
                    errorString = "Add failed, DUID \(enteredDUID) already exists!"
                }
            case "Update":
                if dataModel.update(enteredPerson) {
                    outputViewInfo! += "Updated person: \(enteredDUID) succeeded.\n"
                } else {
                    validInput = false
                    errorString = "Update failed, DUID \(enteredDUID) not found. Added person instead."
                }
            case "Delete":
                if dataModel.delete(enteredDUID) {
                    outputViewInfo! += "Deleted person: \(enteredDUID) succeeded.\n"
                } else {
                    validInput = false
                    errorString = "Delete failed, DUID \(enteredDUID) not found!"
                }
            case "Find":
                if findUUID {
                    let person = dataModel.find(enteredDUID)
                    if person == nil {
                        validInput = false
                        errorString = "Find failed, DUID \(enteredDUID) not found!"
                    } else {
                        outputViewInfo! += person!.description + "\n"
                        // Push a new view
                        pushNewViewController(person!.fName, person!.lName, person!.description, person!.picture)
                    }
                } else {
                    let people = dataModel.find(lastName : enteredPerson.lName == "" ? "*" : enteredPerson.lName, firstName : enteredPerson.fName == "" ? "*" : enteredPerson.fName)
                    if people == nil {
                        validInput = false
                        errorString = "Find failed, No person matches the name \(enteredPerson.lName), \(enteredPerson.fName)!"
                    } else {
                        for person in people! {
                            outputViewInfo! += person.description + "\n"
                        }
                        if people!.count == 1 {
                            // Push a new view
                            pushNewViewController(people![0].fName, people![0].lName, people![0].description, people![0].picture)
                        }
                    }
                }
            case "List All":
                let text = dataModel.list()
                if text == "" {
                    validInput = false
                    errorString = "List failed, no people in the database!"
                } else {
                    outputViewInfo! += text
                }
            case "Help":
                outputViewInfo! += helpText
            default:
                outputViewInfo! += "Unknown error! + \n"
            }
        }
        
        // Handle error message
        if !validInput {
            outputViewInfo! += errorString! + "\n"
            statusLabel.textColor = statusLabelColorRed
            statusLabel.text = "Operation failed!"
        } else {
            // Save data model
            if !dataModel.save() {
                statusLabel.textColor = statusLabelColorRed
                statusLabel.text = "Save failed!"
            } else {
                statusLabel.textColor = statusLabelColorGreen
                statusLabel.text = "Operation succeeded!"
            }
        }
        
        inputFieldDUID.text = ""
        inputFieldParam.text = ""
        outputView.text = outputViewInfo! + "\n"
        
        // Scroll to the bottom of the output view
        scrollToButton()
    }
    
    
    /*
     Parse the input string to create a DukePerson object
     */
    func parseInputString(_ input: String, _ DUID: Int, _ buttonPressed: String) -> DukePerson? {
        // Special case for add a person with no parameters
        if buttonPressed == "Add" && input == "" {
            return DukePerson(DUID: DUID, fName: "", lName: "", email: "", from: "", gender: .Unknown, role: .Unknown)
        }
        if !input.contains("=") {return nil}
        let parameterValuePairs = input.components(separatedBy: ",")
        
        var fName: String = ""
        var lName: String = ""
        var email: String = ""
        var from: String = ""
        var gender: Gender = .Unknown
        var role: Role = .Unknown
        
        // Iterate through the parameter=value pairs and parse them
        for pair in parameterValuePairs {
            let components = pair.components(separatedBy: "=")
            if components.count == 2 {
                let paramName = components[0].trimmingCharacters(in: .whitespaces).lowercased()
                let paramValue = components[1].trimmingCharacters(in: .whitespaces)
                
                switch paramName {
                case "fn":
                    fName = paramValue
                case "ln":
                    lName = paramValue
                case "em":
                    email = paramValue
                case "fr":
                    from = paramValue
                case "ge":
                    gender = Gender(rawValue: paramValue) ?? .Other
                case "ro":
                    role = Role(rawValue: paramValue) ?? .Other
                default:
                    // If the parameter is not recognized, return nil
                    return nil
                }
            }
        }
        
        return DukePerson(DUID: DUID, fName: fName, lName: lName, email: email, from: from, gender: gender, role: role)
    }
    
    
    /*
     Scroll to the bottom of the output view
     */
    func scrollToButton() {
        let contentHeight = outputView.contentSize.height
        let offsetY = max(0, contentHeight - scrollView.bounds.size.height)
        outputView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
    
    
    /*
     Push a stacked student profile view
     */
    func pushNewViewController(_ fName: String, _ lName: String, _ description: String, _ url: String) {
        let pvc = DukePersonVC(nibName: "DukePersonView", bundle: nil)
        pvc.delegate = self
        pvc.firstName = fName
        pvc.lastName = lName
        pvc.descriptionText = description
        pvc.imageUrl = url
        self.present(pvc, animated: true, completion: nil)
    }
    
}

