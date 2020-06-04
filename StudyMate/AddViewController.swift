//
//  AddViewController.swift
//  StudyMate
//
//  Created by user168675 on 6/3/20.
//  Copyright © 2020 Getnet Mekuriyaw. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field:UITextField!
    
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
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        
    }

    

}
