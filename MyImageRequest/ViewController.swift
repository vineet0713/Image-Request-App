//
//  ViewController.swift
//  MyImageRequest
//
//  Created by Vineet Joshi on 1/24/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageURL = URL(string: ImageURLs.FEDERER_SERVE)
        
        // make a request (or task):
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            print("task finished")
            
            // if request completes successfully, the data parameter contains the resource data, and error parameter is nil
            // if request fails, the data parameter is nil, and error parameter contains information about the failure
            if error == nil {
                let downloadedImage = UIImage(data: data!)
                
                performUIUpdatesOnMain {
                    self.myImageView.image = downloadedImage
                    self.placeholderLabel.isHidden = true
                }
            } else {
                print(error!)
            }
        }
        // instead of using the above closure, we could use URLSession's family of delegates to handle running code after the data task is complete
        
        task.resume()
    }
    
}

/*
 
 Notes:
 
 URLSession is a class that can manage network requests on our behalf!

 We can create our own URLSession with custom settings,
 or we can use the shared URLSession that comes preloaded with default settings

 (the shared session is known as a Singleton, which is an object that can only be instantiated once)
 (this shared session will be referring to the SAME object in multiple Swift files throughout the app!)

 For custom URLSessions, we can use the URLSessionConfiguration class
 (which allows us to change things like the amount of time to wait for a network request before cancelling it)


 network requests are known as "tasks" in URLSession
 any task used by URLSession is a subclass of URLSessionTask
 3 main tasks we work with:
      Data (URLSessionDataTask) returns data from the network directly into memory as Data objects (good for short-lived requests!)
      Download (URLSessionDownloadTask) returns data from the network into a temporary file
      Upload (URLSessionUploadTask) are specialized for uploading content
 
 
 
 the URLSession doesn't directly run tasks for us - instead, it gives us methods to create tasks (we have to start the tasks ourselves)
 
*/
