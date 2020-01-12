//
//  PlaySoundExtension.swift
//  Pitch Perfect
//
//  Created by user on 12/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit
import AVFoundation
extension PlaySoundViewController:AVAudioPlayerDelegate{
    struct Alerts {
         static let DismissAlert = "Dismiss"
               static let RecordingDisabledTitle = "Recording Disabled"
               static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
               static let RecordingFailedTitle = "Recording Failed"
               static let RecordingFailedMessage = "Something went wrong with your recording."
               static let AudioRecorderError = "Audio Recorder Error"
               static let AudioSessionError = "Audio Session Error"
               static let AudioRecordingError = "Audio Recording Error"
               static let AudioFileError = "Audio File Error"
               static let AudioEngineError = "Audio Engine Error"
        
    }
    
    
    enum playingState {
        case playing , notPlaying
    }
    
    
    func setupAudio(){
        do{
            audioFile = try AVAudioFile(forReading: playSoundURL as URL)
        } catch{
            showAlert(Alerts.AudioFileError, String (describing: error))
            
            
        }
    }
    
    
    func playSound(rate: Float? = nil , pitch: Float? = nil ,
                   echo: Bool?=false , reverb: Bool? = false 
    ){
        audioEnging = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEnging.attach(audioPlayerNode)
        
        let changeAudioPitchNode = AVAudioUnitTimePitch ()
        if let pitch = pitch{
            changeAudioPitchNode.pitch = pitch
        }
        
        
        if let rate = rate {
            changeAudioPitchNode.rate  = rate
        }
        audioEnging.attach(changeAudioPitchNode)
        
        let EchoNode = AVAudioUnitDistortion()
        EchoNode.loadFactoryPreset(.multiEcho1)
        audioEnging.attach(EchoNode)
        
        
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.largeRoom)
        reverbNode.wetDryMix = 50
        audioEnging.attach(reverbNode)
        
        if echo == true && reverb == true {
            connectAudioNodes(audioPlayerNode , changeAudioPitchNode , EchoNode , reverbNode , audioEnging.outputNode)
        }else if echo == true {
            connectAudioNodes(audioPlayerNode , changeAudioPitchNode , EchoNode , audioEnging.outputNode)
        }else if reverb == true {
            connectAudioNodes(audioPlayerNode , changeAudioPitchNode , reverbNode , audioEnging.outputNode)
        }else {
            connectAudioNodes(audioPlayerNode , changeAudioPitchNode , audioEnging.outputNode)
        }

        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil){
            
            
            var delayInSeconds: Double = 0
                       
                       if let lastRenderTime = self.audioPlayerNode.lastRenderTime, let playerTime = self.audioPlayerNode.playerTime(forNodeTime: lastRenderTime) {
                           
                           if let rate = rate {
                               delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
                           } else {
                               delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
                           }
                       }
                       
                       // schedule a stop timer for when audio finishes playing
                       self.stopTimer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(PlaySoundViewController.stopAudio), userInfo: nil, repeats: false)
            RunLoop.main.add(self.stopTimer, forMode: RunLoop.Mode.default)
        }
        do {
                   try audioEnging.start()
               } catch {
                showAlert(Alerts.AudioEngineError, String(describing: error))
                   return
               }
               
               // play the recording!
               audioPlayerNode.play()
        
    }
    
    func connectAudioNodes(_ nodes: AVAudioNode...){
        for x in 0...nodes.count - 1{
            audioEnging.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
   
    @objc func stopAudio() {
           
           if let audioPlayerNode = audioPlayerNode {
               audioPlayerNode.stop()
           }
           
           if let stopTimer = stopTimer {
               stopTimer.invalidate()
           }
           
           configureUI(.notPlaying)
                           
           if let audioEngine = audioEnging {
               audioEngine.stop()
               audioEngine.reset()
           }
       }
    
    
    
    func configureUI(_ playState: playingState) {
        switch(playState) {
        case .playing:
            setPlayButtonsEnabled(false)
            stopButton.isEnabled = true
        case .notPlaying:
            setPlayButtonsEnabled(true)
            stopButton.isEnabled = false
        }
    }
    
    
    func setPlayButtonsEnabled(_ enabled: Bool) {
        
        
        slowButton.isEnabled = enabled
        speedButton.isEnabled = enabled
           lowPitchButton.isEnabled = enabled
           highPitchButton.isEnabled = enabled
           echoButton.isEnabled = enabled
           reverbButton.isEnabled = enabled
       }
    func showAlert(_ title:String , _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
