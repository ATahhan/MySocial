//
//  CircleView.swift
//  MySocial
//
//  Created by Ammar AlTahhan on 6/6/17.
//  Copyright © 2017 Ammar AlTahhan. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
