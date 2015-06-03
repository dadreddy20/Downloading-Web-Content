//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Anudeep Reddy Dwaram on 03/06/15.
//  Copyright (c) 2015 iDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var webView: UIWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let url = NSURL(string: "http://www.stackoverflow.com")
		
		// task is used to download content from web
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
			// Below is a closure, closures are similar to blocks in C, closures can capture and store references to any constants and variables from the context in which they are defined
			// data contains the content of stackoverflow.com
			(data, response, error) in
			
			// Always check for the error, because users may have slow internet connections
			if(error == nil) {
				var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
				println(urlContent)
				
				// To avoid any delay in diplaying the content of the web page downloaded we use dispatch functions
				dispatch_async(dispatch_get_main_queue()) {
				// We are now inside a closure, to pass the control to viewController we use self
					self.webView.loadHTMLString(urlContent! as String, baseURL: nil)
				}
			}
			else {
				println("User has no proper internet connection")
			}
		}
		
		// Used for both starting and resuming the task
		task.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

