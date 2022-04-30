//
//  EpisodeTableViewHeaderView.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import UIKit

class EpisodeTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Private Properties
    private var titleLabel = UILabel()
    private var numberLabel = UILabel()
    private var nameLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Constants
private extension EpisodeTableViewHeaderView {

    enum Constants {
        enum TitleLabel {
            static let leading: CGFloat = 16
        }
        
        enum NumberLabel {
            static let width: CGFloat = 60
            static let top: CGFloat = 8
            static let bottom: CGFloat = 8
            static let leading: CGFloat = 32
        }

        enum NameLabel {
            static let top: CGFloat = 8
            static let bottom: CGFloat = 8
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -32
        }
    }
    
    enum Font {
        enum Title {
            static let bold = UIFont.systemFont(ofSize: 19, weight: .bold)
        }

        enum Label {
            static let bold = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
    }
    
}

// MARK: - Private Implementation
private extension EpisodeTableViewHeaderView {
    
    func setup() {
        setupTitleLabel()
        setupNumberLabel()
        setupNameLabel()
        setupHierarchy()
        setupConstraints()
    }

    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Title.bold)
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .left

        titleLabel.text = "Title"
    }
    
    func setupNumberLabel() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Label.bold)
        numberLabel.numberOfLines = 1
        numberLabel.lineBreakMode = .byTruncatingTail
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center

        numberLabel.text = "Number"
    }

    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Label.bold)
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.textColor = .black

        nameLabel.text = "Name"
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.TitleLabel.leading),
            
            numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.NumberLabel.top),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.NumberLabel.leading),
            numberLabel.widthAnchor.constraint(equalToConstant: Constants.NumberLabel.width),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.NumberLabel.bottom),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.NameLabel.top),
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: Constants.NameLabel.leading),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.NameLabel.trailing),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.NameLabel.bottom)
        ])
    }
}

