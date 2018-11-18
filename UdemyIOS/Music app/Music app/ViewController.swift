//
//  ViewController.swift
//  Music app
//
//  Created by gayan perera on 11/18/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

     private var audioPlayer :AVAudioPlayer!
    private var selectedAudioFiles : String!
     let audioFiles = ["note1","note2","note3","note4","note5","note6","note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func SoundKeyPress(_ sender: UIButton) {
     
        selectedAudioFiles = audioFiles[sender.tag - 1]
        PlaySound(selectedSound:selectedAudioFiles);
    }
    
    func PlaySound(selectedSound:String) {
        let soundUrl = Bundle.main.url(forResource: selectedAudioFiles, withExtension: "wav")
        
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        }
        catch{
            print(error)
        }
        audioPlayer.play();
    }
    
}

