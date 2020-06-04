//
//  AddViewController.swift
//  StudyMate
//
//  Created by user168675 on 6/3/20.
//  Copyright © 2020 Getnet Mekuriyaw. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field:UITextField!
    
    
    var inputCourse = "New Course"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    
    @objc func saveTask()
    {
        //print("clicked")
        guard let text = field.text, !text.isEmpty else{
            print("field empty")
            
            return
        }
        inputCourse = text
        let courseClass = PFObject(className:"Courses")
        courseClass["courseName"] = inputCourse
        
        courseClass.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
                print("saved")
            } else {
                // There was a problem, check error.description
                print("error Not saved")
                print(error as Any)
            }
        }
    }

    

}
