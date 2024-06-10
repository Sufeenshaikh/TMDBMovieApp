//
//  latestTableViewCell.swift
//  MovieImdbApp
//
//  Created by Dr. Mac on 04/06/24.
//

import UIKit

class latestTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dateTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 12.0
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 2.0
        containerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                   y: containerView.bounds.height - containerView.layer.shadowRadius,
                                                                   width: containerView.bounds.width,
                                                                   height: containerView.layer.shadowRadius)).cgPath
        
        movieImg.layer.cornerRadius = 12.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

