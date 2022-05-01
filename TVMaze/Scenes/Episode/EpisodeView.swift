//
//  EpisodeView.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import UIKit

protocol EpisodeViewDelegate: AnyObject {
    func didTapOnClose()
}

final class EpisodeView: UIView {
    
    // MARK: - Private Properties
    private var closeImage = UIImageView()
    private var numberLabel = UILabel()
    private var nameLabel = UILabel()
    private var thumbImage = UIImageView()
    private var summaryLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Internal Properties
    
    weak var delegate: EpisodeViewDelegate?

    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.activityIndicator.startAnimating()
                    return
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
}

// MARK: - Private Constants
private extension EpisodeView {

    enum Constants {
        enum CloseImage {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -16
            static let height: CGFloat = 16
            static let width: CGFloat = 16
        }

        enum Number {
            static let top: CGFloat = 32
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
        }

        enum Name {
            static let top: CGFloat = 8
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
        }
        
        enum ThumbImage {
            static let top: CGFloat = 32
            static let leading: CGFloat = 24
            static let trailing: CGFloat = -24
            static let height: CGFloat = 180
        }

        enum Summary {
            static let top: CGFloat = 8
            static let leading: CGFloat = 24
            static let trailing: CGFloat = -24
        }
    }
    
    enum Font {
        enum Number {
            static let size : CGFloat = 22
            static let bold = UIFont.systemFont(ofSize: 22, weight: .bold)
        }

        enum Name {
            static let size : CGFloat = 19
            static let bold = UIFont.systemFont(ofSize: 19, weight: .bold)
        }
        
        enum SummaryLabel {
            static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
}

// MARK: - Internal Implementation
extension TVShowDetailView {

}

// MARK: - Private Implemantation
private extension EpisodeView {
    
    func setup() {
        setupActivityIndicator()
        setupCloseImage()
        setupNumberLabel()
        setupNameLabel()
        setupThumbImage()
        setupSummaryLabel()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .systemBlue
        activityIndicator.startAnimating()
        activityIndicator.center = center
    }

    func setupCloseImage() {
        closeImage.translatesAutoresizingMaskIntoConstraints = false
        closeImage.contentMode = .scaleAspectFit
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCloseImage(_:)))
        closeImage.addGestureRecognizer(tapGesture)
        closeImage.isUserInteractionEnabled = true
        
        closeImage.image = UIImage(named: "Close")
    }
    
    func setupThumbImage() {
        thumbImage.translatesAutoresizingMaskIntoConstraints = false
        thumbImage.contentMode = .scaleAspectFit
        
        thumbImage.image = UIImage(named: "ThumbImageLand")
    }

    func setupNumberLabel() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Font.Number.bold)
        numberLabel.numberOfLines = 0
        numberLabel.textColor = .black
        
        numberLabel.text = "E1SE9"
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Font.Name.bold)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        
        nameLabel.text = "Once upon a time in Hollywood"
    }

    func setupSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
        summaryLabel.textColor = .black
    }

    func setupHierarchy() {
        addSubview(activityIndicator)
        addSubview(closeImage)
        addSubview(numberLabel)
        addSubview(nameLabel)
        addSubview(thumbImage)
        addSubview(summaryLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            closeImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.CloseImage.top),
            closeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.CloseImage.trailing),
            closeImage.widthAnchor.constraint(equalToConstant: Constants.CloseImage.width),
            closeImage.heightAnchor.constraint(equalToConstant: Constants.CloseImage.height),

            numberLabel.topAnchor.constraint(equalTo: closeImage.bottomAnchor, constant: Constants.Number.top),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Number.trailing),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Number.leading),
            
            nameLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: Constants.Name.top),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Name.trailing),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Name.leading),

            thumbImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.ThumbImage.top),
            thumbImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ThumbImage.trailing),
            thumbImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ThumbImage.leading),
            
            summaryLabel.topAnchor.constraint(equalTo: thumbImage.bottomAnchor, constant: Constants.ThumbImage.top),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ThumbImage.trailing),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ThumbImage.leading)
        ])
    }
    
    func loadSummaryAttrString(summary: String) -> NSAttributedString? {
        let html = "<html><head><style type=\"text/css\"> body { font-family: -apple-system; font-size: 14px} </style></head><body>" + summary + "</body></html>"
        let data = html.data(using: .utf8)!
        let attributedString = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        
        return attributedString
    }

}

// MARK: - Action Implementation
private extension EpisodeView {
    @objc func didTapCloseImage(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOnClose()
    }
}

// MARK: - Internal Implementation
extension EpisodeView {
    
    func bindEpisodeData(_ episode: Episode) {
        nameLabel.text = episode.name
        numberLabel.text = "E\(String(episode.number))SE\(String(episode.season))"
        summaryLabel.attributedText = loadSummaryAttrString(summary: episode.summary)
    }
    
    func bindImage(imageData: Data?) {
        DispatchQueue.main.async {
            guard let data = imageData,
                  let image = UIImage(data: data) else {
                self.thumbImage.image = UIImage(named: "ThumbImageLand")
                return
            }
            self.thumbImage.image = image
        }
    }
    
}
