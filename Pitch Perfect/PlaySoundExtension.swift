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
            showAler
        }
    }
    
    func showAlert(_ title:String , _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
