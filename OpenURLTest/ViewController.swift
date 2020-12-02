//
//  ViewController.swift
//  OpenURLTest
//
//  Created by Denis Bystruev on 02.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var urlTextFiled: UITextField!
    
    // MARK: - Methods
    func openURL() {
        guard let urlString = urlTextFiled.text else { return }
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            urlTextFiled.resignFirstResponder()
            print(#line, #function, "url =", url)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        urlTextFiled.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextFiled.delegate = self
        urlTextFiled.text = "http://ya.ru"
    }
    
    // MARK: - Actions
    @IBAction func urlTextFieldDidEndOnExit(_ sender: Any) {
        openURL()
    }

    @IBAction func urlButtonTapped(_ sender: UIButton) {
        openURL()
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        openURL()
        return true
    }
}
