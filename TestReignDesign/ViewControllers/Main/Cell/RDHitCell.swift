//
//  RDHitCell.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import DateToolsSwift

class RDHitCell: UITableViewCell {

    @IBOutlet weak var authorAndDateAgoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var hit:RDHit?{
        willSet(newValue){
            self.hit = newValue
        }
        didSet{
            configurateCell()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configurateCell(){
        
        titleLabel.text = hit?.storyText != nil ? hit?.storyText : hit?.storyTitle
        authorAndDateAgoLabel.text = String(format:"%@ - %@",(hit?.author)!,(hit?.createAt?.timeAgoSinceNow)!)
    }
}
