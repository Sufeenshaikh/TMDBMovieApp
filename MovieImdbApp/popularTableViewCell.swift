//
//  popularTableViewCell.swift
//  MovieImdbApp
//
//  Created by Dr. Mac on 04/06/24.
//

import UIKit

class popularTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var dateTitle: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImg.layer.cornerRadius = 14.0
        containerView.layer.cornerRadius = 12.0
//        containerView.layer.masksToBounds = false
//        containerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        containerView.layer.shadowOpacity = 0.5
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowRadius = 2.0
//        containerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                                   y: containerView.bounds.height - containerView.layer.shadowRadius,
//                                                                   width: containerView.bounds.width,
//                                                                   height: containerView.layer.shadowRadius)).cgPath
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
