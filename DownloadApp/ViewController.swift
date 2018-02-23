//
//  ViewController.swift
//  DownloadApp
//
//  Created by Janardhan on 23/02/18.
//  Copyright © 2018 RanganathPavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!


    var yourTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        
        let _ = DownloadManager.shared.activate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        yourTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ViewController.yourFuncToUpdateUI) , userInfo: nil, repeats: true)

    }
    
    func yourFuncToUpdateUI(){
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.progressView.progress = progress
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    
    @IBAction func startDownload(_ sender: Any) {
        let title = urlTextField.text!

        if title.isEmpty == true {
            print("Textfield Empty")
        }else{
            print("Textfield Not Empty")
            let url = URL(string: title)!
            let task = DownloadManager.shared.activate().downloadTask(with: url)
            task.resume()
        }
    }
    
    func callWhenNotificationReceived(){
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder()
        
        return true;
    }
}

