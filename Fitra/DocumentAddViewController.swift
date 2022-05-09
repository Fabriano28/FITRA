//
//  DocumentAddViewController.swift
//  Fitra
//
//  Created by Farrel Brian on 29/04/22.
//

import UIKit

class DocumentAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var descField: UITextField!
    @IBOutlet var catField: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate
        descField.delegate
        catField.delegate
        
        let barItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDocument))
        
        navigationItem.rightBarButtonItem = barItem
        // Do any additional setup after loading the view.
    }
    
    @objc func saveDocument() {
        
        guard let titleText = titleField.text, !titleText.isEmpty else {
            return
        }
        
        guard let descText = descField.text, !descText.isEmpty else {
            return
        }
        
        guard let catText = catField.text, !catText.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(titleText, forKey: "title_\(newCount)")
        UserDefaults().set(descText, forKey: "desc_\(newCount)")
        UserDefaults().set(catText, forKey: "cat_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveDocument()
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
