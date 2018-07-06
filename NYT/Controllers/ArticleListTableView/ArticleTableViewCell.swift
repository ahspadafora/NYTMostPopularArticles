//
//  ArticleCellTableViewCell.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    var article: Article? {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.article?.title
                self.bylineLabel.text = self.article?.byline
                self.publishedDateLabel.text = self.article?.published_date
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
}
