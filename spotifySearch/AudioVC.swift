//
//  AudioVC.swift
//  spotifySearch
//
//  Created by Elliot Young on 12/16/16.
//  Copyright © 2016 Elliot Young. All rights reserved.
//

import Foundation
import UIKit
class AudioVC: UIViewController {
    var image = UIImage()
    var mainSongTitle = String()
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
    }
}
