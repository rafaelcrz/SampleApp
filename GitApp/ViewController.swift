//
//  ViewController.swift
//  GitApp

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textViewGists: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionFetch(_ sender: Any) {
        API().getGists { response in
            guard let response = response else {
                return
            }
            
            DispatchQueue.main.async {
                self.textViewGists.text = "Owner: \(response.owner?.login ?? "")\nDescription: \(response.description ?? "")"
            }
        }
    }
}
