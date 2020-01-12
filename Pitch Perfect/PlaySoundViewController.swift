//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by user on 12/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundViewController: UIViewController {

    @IBOutlet weak var slowButton:UIButton!
    @IBOutlet weak var speedButton:UIButton!
    @IBOutlet weak var lowPitchButton:UIButton!
    @IBOutlet weak var highPitchButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    
    @IBOutlet weak var stopButton:UIButton!
    
    
    var playSoundURL:URL!
    var audioFile:AVAudioFile!
    var audioEnging:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer:Timer!
    
    enum playMode: Int{
        case slow = 0  , speed , lowPitch , highPitch , reverbed , echoed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (playSoundURL)
        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.isEnabled = false
    }
    
    @IBAction func playSound(_ sender: UIButton){
        print ("Play sound fired.")
        switch (playMode(rawValue: sender.tag)!){
        case .slow:
            playSound(rate: 0.5)
        case .speed:
            playSound(rate: 1.5)
       
        case .lowPitch:
            playSound( pitch: -1000)
        case .highPitch:
            playSound( pitch: 1000)
        case .reverbed:
            playSound( reverb: true)
        case .echoed:
            playSound(echo: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopPlaying(_ sender: UIButton){
        print ("Stop playing.")
        stopAudio()
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
