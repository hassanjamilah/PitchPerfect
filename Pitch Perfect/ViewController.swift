//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by user on 12/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordLabel:UILabel!
    
    @IBOutlet weak var recordButton:UIButton!
    @IBOutlet weak var stopRecordingButton:UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func startRecording (_ sender: UIButton){
        print ("Start recording action fired")
    }
    
    @IBAction func stopRecording (_ sender: UIButton){
        print ("Stop recording action fired.")
    }
   


}

