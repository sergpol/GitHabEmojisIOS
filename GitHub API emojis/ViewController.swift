//
//  ViewController.swift
//  GitHub API emojis
//
//  Created by Сергей Полицинский on 07.09.2018.
//  Copyright © 2018 GitHub. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UITableViewController {
    let apiBaseURL = "https://api.github.com/"
    var emojisList: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "Cell")
        getEmojis()
        getEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getEmojis() {
        let emojiURL = "emojis"
        
        Alamofire.request(apiBaseURL + emojiURL).responseJSON { response in
            if let responseValue = response.result.value {
                let json = JSON(responseValue)
                print(json)
                
                for (key,subJson):(String, JSON) in json {
                    // Do something you want
                    let emoji = Emoji()
                    emoji.name = key
                    emoji.url = subJson.stringValue
                    self.emojisList.append(emoji)
                }
                
                self.emojisList.sort(by: {(em1, em2) in
                    return em2.name > em1.name
                })
                
                self.tableView.reloadData()
            }
        }
    }
    
    func getEvents() {
        let emojiURL = "events"
        Alamofire.request(apiBaseURL + emojiURL).responseJSON { response in
            if let responseValue = response.result.value {
                let json = JSON(responseValue)
                print(json)
                let events = [Event](json: json.stringValue)
                print(events)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyCell {
            cell.emojiImageView.image = nil
            
            let emoji = emojisList[indexPath.row]
            cell.emojiName.text = emoji.name
            cell.emojiImageView.af_setImage(withURL: URL(string: emoji.url)!,
               placeholderImage: nil,
               imageTransition: UIImageView.ImageTransition.crossDissolve(0.25),
               runImageTransitionIfCached: false,
               completion: {(image) in }
            )
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojisList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}

