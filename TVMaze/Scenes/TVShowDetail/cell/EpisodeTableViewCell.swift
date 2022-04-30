//
//  EpisodeTableViewCell.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private var numberLabel = UILabel()
    private var nameLabel = UILabel()
    
    // MARK: - Internal Properties
    var number: String = "" {
        didSet {
            numberLabel.text = number
        }
    }

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
        setup()
    }

}

// MARK: - Private Constants
private extension EpisodeTableViewCell {

    enum Constants {
        enum NumberLabel {
            static let width: CGFloat = 60
            static let leading: CGFloat = 32
        }

        enum NameLabel {
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -32
        }
    }
    
    enum Font {
        enum Label {
            static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
}

// MARK: - Private Implementation
private extension EpisodeTableViewCell {
    
    func setup() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupNumberLabel()
        setupNameLabel()
        setupHierarchy()
        setupConstraints()
    }

    func setupNumberLabel() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Label.regular)
        numberLabel.numberOfLines = 1
        numberLabel.lineBreakMode = .byTruncatingTail
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center

        numberLabel.text = "99"
    }

    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Label.regular)
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.textColor = .black

        nameLabel.text = "Free WipesFree WipesFree WipesFree WipesFree WipesFree Wipes"
    }
    
    func setupHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.NumberLabel.leading),
            numberLabel.widthAnchor.constraint(equalToConstant: Constants.NumberLabel.width),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: Constants.NameLabel.leading),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.NameLabel.trailing)
        ])
    }
}
