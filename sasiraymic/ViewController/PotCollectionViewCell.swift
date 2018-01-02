//
//  PotCollectionViewCell.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 1/1/18.
//  Copyright © 2018 com.sasiluk. All rights reserved.
//

import Foundation
import SDWebImage
import SnapKit

class PotCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setup(url: String) {
        let dimension = ((UIScreen.main.bounds.width-20)/3)
        let w = dimension
        let h = dimension
        
        self.imageView.sd_setShowActivityIndicatorView(true)
        self.imageView.sd_setIndicatorStyle(.white)
        self.imageView.sd_setImage(with: URL(string: url),
                                   placeholderImage: nil,
                                   options: .scaleDownLargeImages,
                                   completed: nil)
        
        self.contentView.addSubview(self.imageView)
        
        
        self.imageView.snp.makeConstraints { m in
            m.width.equalTo(w)
            m.height.equalTo(h)
            m.left.equalTo(self.contentView.snp.left).offset(10)
            m.right.equalTo(self.contentView.snp.right).offset(10)
        }
        
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
