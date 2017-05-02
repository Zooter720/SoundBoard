//
//  SoundViewController.swift
//  Sound Board
//
//  Created by NOAA Education and Outreach on 5/2/17.
//  Copyright © 2017 PMG. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addbutton: UIButton!
    
    
    var audioRecorder : AVAudioRecorder? = nil
    var audioPlayer :  AVAudioPlayer? = nil
    var audioURL : URL?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func setupRecorder(){
        do{
            //Create an Audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Create URL for Audio File
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first!
            let pathComponents = [basePath,"audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //print("********************")
            //print(audioURL)
            
            //Crreate audioRecorder Settings
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            //Create AudioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch {
            //This would handle the error if thrown
        }
        
    }
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording{
            //stop the recording
            audioRecorder?.stop()
            
            //change button title to record
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            
        }else{
            //start recording
            audioRecorder?.record()
            
            //change button to stop
            recordButton.setTitle("Stop", for: .normal)
            
        }
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        }
        catch{}
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
}
