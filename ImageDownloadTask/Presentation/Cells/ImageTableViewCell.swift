//
//  ImageTableViewCell.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import UIKit
import Nuke
import SnapKit


protocol ImageCellModel {
    var imageUrl: URL { get }
    var tags: String? { get }
    var sizeRatio: Float { get }
}

struct DefaultImageCellModel: ImageCellModel {
    let imageUrl: URL
    let tags: String?
    let sizeRatio: Float
}

final class ImageTableViewCell: CommonInitTableViewCell {
    
    static var reuseId: String {
        return String(describing: ImageTableViewCell.self)
    }
    
    private let pictureImageView = UIImageView()
    private let imageActivityIndicator = UIActivityIndicatorView(style: .medium)
    private let tagsNameLabel = UILabel()
    
    override func setup() {
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        
        tagsNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tagsNameLabel.textColor = .black
        
        pictureImageView.clipsToBounds = true
        pictureImageView.setRounded()
    }
    
    private func setupLayout() {
        
        addSubviews([
            pictureImageView,
            tagsNameLabel
        ])
        
        pictureImageView.addSubview(imageActivityIndicator)
        
        imageActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        pictureImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(48)
        }
        
        tagsNameLabel.snp.makeConstraints {
            $0.top.equalTo(pictureImageView.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.nuke_display(image: nil)
    }
    
    func configureWith(cellModel: ImageCellModel) {
        
        imageActivityIndicator.startAnimating()
        setupLayout()
        tagsNameLabel.text = cellModel.tags
        
        loadImage(
            with: cellModel.imageUrl,
            options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
            into: pictureImageView,
            completion: { [weak self] _ in
                self?.imageActivityIndicator.stopAnimating()
            }
        )
        
       
    }
    
}
