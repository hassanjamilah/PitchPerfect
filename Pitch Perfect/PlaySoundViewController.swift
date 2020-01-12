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
    
    //MARK: Prepare the audio file for playing
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    //MARK: Disable the stop button before appearing on the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.isEnabled = false
    }
    
    //MARK: This action is fired when one of the play buttons is clicked
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
    
    //MARK: This action is fired when the stop playing button clicked
    @IBAction func stopPlaying(_ sender: UIButton){
        print ("Stop playing.")
        stopAudio()
        configureUI(.notPlaying)
    }
    
    
}
