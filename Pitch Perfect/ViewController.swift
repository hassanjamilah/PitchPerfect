//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by user on 12/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController , AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordLabel:UILabel!
    
    @IBOutlet weak var recordButton:UIButton!
    @IBOutlet weak var stopRecordingButton:UIButton!
    
    let recordingStr = "Recording..."
    let finishedRecordingStr = "Press the record button"

    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: Disable the stop recording button before appearing on the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false ;
    }
    
    //MARK: This action is fired when we click on the recording button
    @IBAction func startRecording (_ sender: UIButton){
        print ("Start recording action fired")
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        recordLabel.text = recordingStr
        
        doRecording()
    }
    
    //MARK: stop the recording operation
    @IBAction func stopRecording (_ sender: UIButton){
        print ("Stop recording action fired.")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordLabel.text = finishedRecordingStr
        
       stopRecording()
    }
    
    //MARK: do the recording operation
    func doRecording(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let fileName = "recordedSound.wav"
        let fullPath = [path , fileName]
        let url = URL(string: fullPath.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: url!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
   
    //MARK: stop the recording.
    func stopRecording(){
               audioRecorder.stop()
               let session = AVAudioSession.sharedInstance()
               try! session.setActive(false)
    }

    //MARK: This method is to launch the second view controller after we ensure that the sound file is saved
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print ("Finished recording successfully.")
            performSegue(withIdentifier: "gotoPlaySoundSegue", sender: audioRecorder.url)
        }else {
            print ("Failed to record.")
        }
    }

    //MARK: This is for preparing and passing the url to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier  == "gotoPlaySoundSegue"{
            print ("Saving the url")
            let vc = segue.destination as! PlaySoundViewController
            let url = sender as! URL
            vc.playSoundURL = url
            
        }
    }
}

