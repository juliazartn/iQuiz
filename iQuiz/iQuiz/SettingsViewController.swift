//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/16/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit
import SystemConfiguration

class SettingsViewController: UIViewController {

    @IBOutlet weak var URLTextField: UITextField!
    
    var subjectRepo : SubjectRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        URLTextField.text = "https://tednewardsandbox.site44.com/questions.json"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkNowClicked(_ sender: Any) {
        let connected = self.isConnectedToNetwork()
        if connected {
            subjectRepo?.setURL(url: URLTextField.text!)
            
        } else {
            let alert = UIAlertController(title: "Network Alert", message: "Network is not available", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mainView = segue.destination as! ViewController
        mainView.subjectRepo = subjectRepo!
    }
    
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
    private func isConnectedToNetwork() -> Bool {
        
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com") else { return false }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        if !isNetworkReachable(with: flags) {
            // Device doesn't have internet connection
            return false
        }
        #if os(iOS)
            // It's available just for iOS because it's checking if the device is using mobile data
            if flags.contains(.isWWAN) {
                // Device is using mobile data
                return true
            }
        #endif
        // At this point we are sure that the device is using Wifi since it's online and without using mobil
        return true

    }
}
