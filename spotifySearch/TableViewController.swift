//
//  ViewController.swift
//  spotifySearch
//
//  Created by Elliot Young on 12/15/16.
//  Copyright © 2016 Elliot Young. All rights reserved.
//
import UIKit
import Alamofire
struct post {
    let mainImage : UIImage!
    let name : String!
}
class TableViewController: UITableViewController {
    var searchUrl = "https://api.spotify.com/v1/search?q=Portugal+The+Man&type=track&market=US&limit=10&offset=5"
    typealias JSONStandard = [String: AnyObject]
    var posts = [post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchUrl)
    }
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    func parseData(JSONData: Data){
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard{
                if let items = tracks["items"] as? [JSONStandard] {
                    for i in 0..<items.count {
                        let item = items[i]
                        let name = item["name"] as! String
                        if let album = item["album"] as? JSONStandard{
                            if let images = album["images"] as? [JSONStandard]{
                                let imageData = images[0]
                                let mainImageURL = URL(string:imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageURL!)
                                let mainImage = UIImage(data: mainImageData as! Data)
                                posts.append(post.init(mainImage: mainImage, name: name))
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
            }
            print(readableJSON)
        }
        catch{
            print(error)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainImageView.image = posts[indexPath.row].mainImage
        mainLabel.text = posts[indexPath.row].name
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
    }

}

