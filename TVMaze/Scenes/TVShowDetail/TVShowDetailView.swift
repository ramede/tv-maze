//
//  TVShowDetailView.swift
//  TVMaze
//
//  Created by Râmede on 29/04/22.
//

import UIKit

final class TVShowDetailView: UIView {
    
    var episodes = [ ["Moscow", "Saint Petersburg", "Novosibirsk", "Novosibirsk", "Nizhny Novgorod", "Samara", "Omsk" ], ["Kiyv", "Odessa", "Donetsk", "Harkiv", "Lviv", "Uzhgorod", "Zhytomyr", "Luhansk", "Mikolayv", "Kherson"], ["Berlin", "Hamburg", "Munich", "Cologne", "Frankfurt", "Stuttgart", "Düsseldorf", "Dortmund", "Essen", "Bremen"]]
    
    // MARK: - Private Properties
    
    private var contentScrollView = UIScrollView()
    private var contentView = UIView()
    private var nameLabel = UILabel()
    private var thumbImage = UIImageView()
    private var ratingLabel = UILabel()
    private var genresLabel = UILabel()
    private var scheduleLabel = UILabel()
    private var summaryLabel = UILabel()
    private var episodesTableView = UITableView()
    
    private var tableViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()

        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
            self.tableViewHeightConstraint.constant = self.episodesTableView.contentSize.height
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Private Constants
private extension TVShowDetailView {

    enum Constants {
        enum Name {
            static let top: CGFloat = 4
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
        }
        
        enum ThumbImage {
            static let top: CGFloat = 16
            static let leading: CGFloat = 16
            static let bottom: CGFloat = -16
            static let height: CGFloat = 150
            static let width: CGFloat = 120
        }
        
        enum RatingLabel {
            static let top: CGFloat = 8
        }
        
        enum SummaryLabel {
            static let top: CGFloat = 8
            static let height: CGFloat = 300
        }
        
        enum ScheduleLabel {
            static let top: CGFloat = 8
        }

        enum GenresLabel {
            static let leading: CGFloat = 8
            static let trailing: CGFloat = -24
        }
        
        enum EpisodesTableView {
            static let top: CGFloat = 8
            static let trailing: CGFloat = -16
            static let bottom: CGFloat = -8
            static let leading: CGFloat = 16
        }
        
    }
    
    enum Font {
        enum Name {
            static let size : CGFloat = 22
            static let bold = UIFont.systemFont(ofSize: 22, weight: .bold)
        }

        enum GenresLabel {
            static let bold = UIFont.systemFont(ofSize: 15, weight: .bold)
        }
        
        enum ScheduleLabel {
            static let bold = UIFont.systemFont(ofSize: 14, weight: .bold)
            static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        }

        enum SummaryLabel {
            static let regular = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
}

// MARK: - Private Implemantation
private extension TVShowDetailView {
    
    func setup() {
        setupContentScrollView()
        setupContentView()
        setupNameLabel()
        setupThumbImage()
        setupRatingLabel()
        setupGenresLabel()
        setupScheduleLabel()
        setupSummaryLabel()
        setupTableView()
        setupHierarchy()
        setupConstraints()
    }

    func setupContentScrollView() {
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.backgroundColor = .clear
    }

    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
    }

    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Font.Name.bold)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        
        nameLabel.text = "Once upon a time in Hollywood"
    }

    func setupRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.SummaryLabel.regular)
        ratingLabel.numberOfLines = 1
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center

        ratingLabel.text = "⭐ 8.5"
    }

    func setupThumbImage() {
        thumbImage.translatesAutoresizingMaskIntoConstraints = false
        thumbImage.widthAnchor.constraint(equalToConstant: Constants.ThumbImage.width).isActive = true
        thumbImage.heightAnchor.constraint(equalToConstant: Constants.ThumbImage.height).isActive = true
        thumbImage.contentMode = .scaleAspectFit
        
        thumbImage.image = UIImage(named: "ThumbImage")
    }
    
    func setupGenresLabel() {
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.GenresLabel.bold)
        genresLabel.numberOfLines = 0
        genresLabel.textColor = .black
        
        
        genresLabel.text = "Drama | Crime | Legal"
    }
    
    func setupScheduleLabel() {
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        scheduleLabel.numberOfLines = 0
        
        let myString = "Schedule: Mondays at 21:00 (60 min)"
        var myMutableString = NSMutableAttributedString()

        myMutableString = NSMutableAttributedString(string: myString, attributes: [
            NSAttributedString.Key.font: Font.ScheduleLabel.regular,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        myMutableString.addAttribute(NSAttributedString.Key.font, value: Font.ScheduleLabel.bold, range: NSRange(location:0,length:9))

        scheduleLabel.attributedText = myMutableString
    }

    func setupSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.SummaryLabel.regular)
        summaryLabel.numberOfLines = 0
        summaryLabel.textColor = .black
        
        summaryLabel.text = "Follow Better Call Saul is the prequel to the award-winning series Breaking Bad, set six years before Saul Goodman became Walter White's lawyer. When we meet him, the man who will become Saul Goodman is known as Jimmy McGill, a small-time lawyer searching for his destiny, and, more immediately, hustling to make ends meet. Working alongside, and often against, Jimmy is fixer Mike Ehrmantraut, a beloved character introduced in Breaking Bad. The series will track Jimmy's transformation into Saul Goodman, the man who puts criminal in criminal lawyer.Follow Better Call Saul is the prequel to the award-winning series Breaking Bad, set six years before Saul Goodman became Walter White's lawyer. When we meet him, the man who will become Saul Goodman is known as Jimmy McGill, a small-time lawyer searching for his destiny, and, more immediately, hustling to make ends meet. Working alongside, and often against, Jimmy is fixer Mike Ehrmantraut, a beloved character introduced in Breaking Bad. The series will track Jimmy's transformation into Saul Goodman, the man who puts criminal in criminal lawyer.Follow Better Call Saul is the prequel to the award-winning series Breaking Bad, set six years before Saul Goodman became Walter White's lawyer. When we meet him, the man who will become Saul Goodman is known as Jimmy McGill, a small-time lawyer searching for his destiny, and, more immediately, hustling to make ends meet. Working alongside, and often against, Jimmy is fixer Mike Ehrmantraut, a beloved character introduced in Breaking Bad. The series will track Jimmy's transformation into Saul Goodman, the man who puts criminal in criminal lawyer.Follow Better Call Saul is the prequel to the award-winning series Breaking Bad, set six years before Saul Goodman became Walter White's lawyer. When we meet him, the man who will become Saul Goodman is known as Jimmy McGill, a small-time lawyer searching for his destiny, and, more immediately, hustling to make ends meet. Working alongside, and often against, Jimmy is fixer Mike Ehrmantraut, a beloved character introduced in Breaking Bad. The series will track Jimmy's transformation into Saul Goodman, the man who puts criminal in criminal lawyer."
    }
    
    func setupTableView() {
        tableViewHeightConstraint = NSLayoutConstraint(
            item: episodesTableView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate([tableViewHeightConstraint])

        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "episodeCell")
        episodesTableView.register(EpisodeTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "episodeSectionHeader")
        episodesTableView.backgroundColor = .clear
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.isScrollEnabled = false
    }
    
    func setupHierarchy() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(thumbImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(episodesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Name.top),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Name.leading),
            
            thumbImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.ThumbImage.top),
            thumbImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: thumbImage.bottomAnchor, constant: Constants.RatingLabel.top),
            ratingLabel.trailingAnchor.constraint(equalTo: thumbImage.trailingAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: thumbImage.leadingAnchor),
            
            genresLabel.topAnchor.constraint(equalTo: thumbImage.topAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: thumbImage.trailingAnchor, constant: Constants.GenresLabel.leading),
            genresLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.GenresLabel.trailing),
            
            scheduleLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: Constants.ScheduleLabel.top),
            scheduleLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            scheduleLabel.trailingAnchor.constraint(equalTo: genresLabel.trailingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: Constants.SummaryLabel.top),
            summaryLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: genresLabel.trailingAnchor),
            
            episodesTableView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: Constants.EpisodesTableView.top),
            episodesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.EpisodesTableView.trailing),
            episodesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            episodesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.EpisodesTableView.leading)
        ])
    }
    
}

// MARK: - TableViewData DataSource
extension TVShowDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "episodeCell",
            for: indexPath
        ) as? EpisodeTableViewCell else { return UITableViewCell() }
        
        return cell
    }

}

// MARK: - TableViewData Delegate
extension TVShowDetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "episodeSectionHeader") as! EpisodeTableViewHeaderView
        
       return view
    }

}
