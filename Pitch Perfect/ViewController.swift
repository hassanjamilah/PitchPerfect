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
    
    let recordingStr = "Recording..."
    let finishedRecordingStr = "Press the record button"
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false ;
    }
    
    
    @IBAction func startRecording (_ sender: UIButton){
        print ("Start recording action fired")
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        recordLabel.text = recordingStr
    }
    
    @IBAction func stopRecording (_ sender: UIButton){
        print ("Stop recording action fired.")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordLabel.text = finishedRecordingStr
    }
   


}

