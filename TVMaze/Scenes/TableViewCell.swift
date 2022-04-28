//
//  TableViewCell.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private var nameLabel = UILabel()
    private var ratingLabel = UILabel()
    private var wrappedView = UIView()
    private var thumbImage = UIImageView()
    
    // MARK: - Public Properties
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setup()
    }
    
}

// MARK: - Private Constants
private extension TableViewCell {
    
    enum Constants {
        enum WrappedView {
            static let leading: CGFloat = 8
            static let trailing: CGFloat = -16
            static let height: CGFloat = 40
        }
        
        enum NameLabel {
            static let top: CGFloat = 0
            static let leading: CGFloat = 0
            static let trailing: CGFloat = 0
            static let width: CGFloat = 35
        }

        enum RatingLabel {
            static let top: CGFloat = 8
            static let leading: CGFloat = 0
            static let trailing: CGFloat = 0
        }

        enum ThumbImage {
            static let top: CGFloat = 16
            static let leading: CGFloat = 16
            static let bottom: CGFloat = -16
            static let height: CGFloat = 100
            static let width: CGFloat = 80
        }
    }
    
    enum Font {
        enum Name {
            static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        }

        enum Rating {
            static let regular = UIFont.systemFont(ofSize: 11, weight: .regular)
        }
    }
    
}

// MARK: - Private Implementation
private extension TableViewCell {
    
    func setup() {
        setupThumbImage()
        setupWrappedView()
        setupNameLabel()
        setupRatingLabel()
        setupHierarchy()
        setupConstraints()
    }

    func setupThumbImage() {
        thumbImage.translatesAutoresizingMaskIntoConstraints = false
        thumbImage.widthAnchor.constraint(equalToConstant: Constants.ThumbImage.width).isActive = true
        thumbImage.heightAnchor.constraint(equalToConstant: Constants.ThumbImage.height).isActive = true
        thumbImage.image = UIImage(named: "ThumbImage")
        thumbImage.contentMode = .scaleAspectFit
    }

    func setupWrappedView() {
        wrappedView.translatesAutoresizingMaskIntoConstraints = false
        wrappedView.heightAnchor.constraint(equalToConstant: Constants.WrappedView.height).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Name.regular)
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.textColor = .black
    }
    
    func setupRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Rating.regular)
        ratingLabel.numberOfLines = 1
        ratingLabel.textColor = .black
        ratingLabel.text = "⭐ 6.5"
    }
        
    func setupHierarchy() {
        contentView.addSubview(thumbImage)
        contentView.addSubview(wrappedView)
        wrappedView.addSubview(nameLabel)
        wrappedView.addSubview(ratingLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.ThumbImage.top),
            thumbImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ThumbImage.leading),
            thumbImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.ThumbImage.bottom),
            
            wrappedView.leadingAnchor.constraint(equalTo: thumbImage.trailingAnchor, constant: Constants.WrappedView.leading),
            wrappedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.WrappedView.trailing),
            wrappedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: wrappedView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: wrappedView.leadingAnchor, constant: Constants.NameLabel.leading),
            nameLabel.trailingAnchor.constraint(equalTo: wrappedView.trailingAnchor, constant: Constants.NameLabel.trailing),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.RatingLabel.top),
            ratingLabel.leadingAnchor.constraint(equalTo: wrappedView.leadingAnchor)
        ])
    }
    
}
