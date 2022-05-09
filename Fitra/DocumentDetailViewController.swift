//
//  DocumentDetailViewController.swift
//  Fitra
//
//  Created by Farrel Brian on 29/04/22.
//

import UIKit

class DocumentDetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    
    var documentTitle: String?
    var documentDesc: String?
    var documentCat: String?
    var defaultTitle = "NoDocument"
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let barItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteDocument))
        navigationItem.rightBarButtonItem = barItem
        titleLabel.text = documentTitle
        descTextView.text = documentDesc
        // Do any additional setup after loading the view.
    }
    
    @objc func deleteDocument() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }

        update?()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openDocument() {
        let pdfVC = storyboard?.instantiateViewController(withIdentifier: "PDFKit") as! PDFKitViewController
        pdfVC.title = documentTitle
        pdfVC.fileName = documentTitle ?? defaultTitle
        navigationController?.pushViewController(pdfVC, animated: true)
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
