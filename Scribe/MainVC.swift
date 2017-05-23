//
//  MainVC.swift
//  Scribe
//
//  Created by Brennan Linse on 5/23/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var transcriptionTextView: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let err = error {
                            print("There was an error: \(err)")
                        } else {
                            if let transcribedString = result?.bestTranscription.formattedString {
                                self.transcriptionTextView.text = transcribedString
                            }
                        }
                    }
                }
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        requestSpeechAuth()
    }

}
