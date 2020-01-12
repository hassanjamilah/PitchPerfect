//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by user on 12/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class PlaySoundViewController: UIViewController {

    @IBOutlet weak var slowButton:UIButton!
    @IBOutlet weak var speedButton:UIButton!
    @IBOutlet weak var lowPitchButton:UIButton!
    @IBOutlet weak var highPitchButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    
    @IBOutlet weak var stopButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.isEnabled = false
    }
    
    @IBAction func playSound(_ sender: UIButton){
        print ("Play sound fired.")
    }
    
    @IBAction func stopPlaying(_ sender: UIButton){
        print ("Stop playing.")
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
