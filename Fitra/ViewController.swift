//
//  ViewController.swift
//  Fitra
//
//  Created by Farrel Brian on 29/04/22.
// Atrribution : 
//  Photo by Alfons Morales on Unsplash, Photo by Mockup Photos on Unsplash

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var documentTableView: UITableView!
    @IBOutlet var countLabel: UILabel!
    
//    let data: [DocumentStructure] = [
//        DocumentStructure(titleLabel: "Doc1", descLabel: "Desc1", categoryLabel: "Uncategorized"),
//        DocumentStructure(titleLabel: "Doc2", descLabel: "Desc2", categoryLabel: "Uncategorized"),
//        DocumentStructure(titleLabel: "Doc3", descLabel: "Desc3", categoryLabel: "Uncategorized")
//    ]
    
    var documents: [DocumentStructure] = []
    let color01 = UIColor(red: 28, green: 28, blue: 30, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbarSettings()
        self.title = "FITRA"
        // Do any additional setup after loading the view.
        documentTableView.dataSource = self
        documentTableView.delegate = self
        documentTableView.rowHeight = UITableView.automaticDimension
        documentTableView.estimatedRowHeight = 150
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        countLabel.text =  "\(UserDefaults().value(forKey: "count") as? Int ?? 0)"
        updateDocuments()
    }
    
    @IBAction func addDocument () {
        let addVC = storyboard?.instantiateViewController(withIdentifier: "DocumentAdd") as! DocumentAddViewController
        addVC.title = "Add New Document"
        addVC.update = {
            DispatchQueue.main.async {
                self.updateDocuments()
            }
        }
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func navbarSettings() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color01

        // setup title font color
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = titleAttribute

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]//user global variable
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.black //user global variable
//        self.navigationController?.navigationBar.tintColor = UIColor.black //user global variable
//        self.tabBarController?.tabBar.barTintColor = UIColor.black
//        view.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    }
    
    func updateDocuments() {
        
        documents.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for i in 0..<count {
            
            guard let documentTitle = UserDefaults().value(forKey: "title_\(i + 1)") as? String else {
                return
            }
            
            guard let documentDesc = UserDefaults().value(forKey: "desc_\(i + 1)") as? String else {
                return
            }
            
            guard let documentCat = UserDefaults().value(forKey: "cat_\(i + 1)") as? String else {
                return
            }
            
            let data = DocumentStructure(titleLabel: documentTitle, descLabel: documentDesc, categoryLabel: documentCat)
            
            documents.append(data)
        }
        
        documentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let document = documents[indexPath.row]
        
        let documentCell = documentTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath) as! CustomTableViewCell
        
        documentCell.titleLabel.text = "\(document.titleLabel).pdf"
        documentCell.descLabel.text = document.descLabel
        documentCell.catBtn.setTitle(document.categoryLabel, for: .normal)
        
        return documentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        documentTableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DocumentDetail") as! DocumentDetailViewController
        detailVC.title = "\(documents[indexPath.row].titleLabel)"
        detailVC.documentTitle =  documents[indexPath.row].titleLabel
        detailVC.documentDesc = documents[indexPath.row].descLabel
        detailVC.documentCat = documents[indexPath.row].categoryLabel
        
        detailVC.update = {
            DispatchQueue.main.async {
                self.updateDocuments()
            }
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 125
//    }

}

