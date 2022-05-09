//
//  PDFKitViewController.swift
//  Fitra
//
//  Created by Farrel Brian on 29/04/22.
//
import PDFKit
import UIKit

class PDFKitViewController: UIViewController {

    let pdfView = PDFView()
    var fileName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfView)
        // Do any additional setup after loading the view.
        showPDF()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
        
    }
    
    func showPDF(){
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "pdf") else {
            return
        }
        
        guard let document = PDFDocument(url: url) else {
            return
        }
        
        pdfView.document = document
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
