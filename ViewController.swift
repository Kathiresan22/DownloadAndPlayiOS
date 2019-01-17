//
//  ViewController.swift
//  LocalMediaPlayer
//
//  Created by Ventuno Technologies on 17/01/19.
//  Copyright © 2019 Ventuno Technologies. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController  {
    
    
     let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer?
    
    @IBAction func PlayVideo(_ sender: Any) {
        
        
                self.present(self.avPlayerViewController, animated: true) {
                    self.avPlayerViewController.player?.play()
                }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.mp4")
        
        print(destinationFileUrl)
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: "https://vtnpmds-a.akamaihd.net/669/17-10-2018/MMV1250715_TEN_640x360__H41QKIPR.mp4")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        let request = URLRequest(url:fileURL!)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    self.playVideo(filepath: destinationFileUrl)

                }

                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }

            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        
    
        
    }
    
    func playVideo(filepath : URL)
    {
      
        
        //let movieUrl:URL? = URL(fileURLWithPath: "")
        
        let movieUrl:URL? = filepath
        
        if let final_url = movieUrl{
            
            avPlayer = AVPlayer(url: final_url)
            avPlayerViewController.player = avPlayer
        }
//        self.present(self.avPlayerViewController, animated: true) {
//            self.avPlayerViewController.player?.play()
//        }

      //  avPlayerViewController.player?.play()
    }
}
