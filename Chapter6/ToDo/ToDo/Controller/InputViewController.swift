//
//  InputViewController.swift
//  ToDo
//
//  Created by Rohan Bhale on 18/06/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit
import CoreLocation
class InputViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    @IBAction func save() {
        guard let titleString = titleTextField.text, titleString.characters.count > 0 else { return }
        let date: Date?
        
        if let dateText = dateTextField.text, dateText.characters.count > 0 {
            date = dateFormatter.date(from:dateText)
        } else {
            date = nil
        }
        
        let descriptionString : String?
        if let itemDescription = descriptionTextField.text, itemDescription.characters.count > 0 {
            descriptionString = itemDescription
        } else{
            descriptionString = nil
        }
        if let locationName = locationTextField.text, locationName.characters.count > 0 {
            if let address = addressTextField.text, address.characters.count > 0 {
                geocoder.geocodeAddressString(address) { [unowned self](placeMarks, error) in
                    let placeMark = placeMarks?.first
                    let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
                    DispatchQueue.main.async {
                        self.itemManager?.add(item)
                        self.dismiss(animated: true)
                    }
                }
            } else {
                let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName))
                
                self.itemManager?.add(item)
                dismiss(animated: true)
            }
        } else {
            let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
            self.itemManager?.add(item)
            dismiss(animated: true)
        }
        
        
    }
    
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
}
