//
//  TableViewCell.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import UIKit

//protocol CountersTableViewCellDelegate: AnyObject {
//    func didIncrementTapped(cell: CountersTableViewCell, countId: String?)
//    func didDecrementTapped(cell: CountersTableViewCell, countId: String?)
//}

class TableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private var label = UILabel()
    //private var countStepper = UIStepper()
    //private var dividerView = UIView()
    private var mainView = UIView()
    //private var titleLabel = UILabel()
    
    // MARK: - Public Properties
    //var countId: String?
    
    //    var count: Int = 0 {
    //        didSet {
    //            countLabel.text = String(count)
    //            countStepper.value = Double(count)
    //        }
    //    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    //weak var delegate: CountersTableViewCellDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setup()
    }
    
    @objc
    private func dismissAction() {
    }
    
    @objc
    private func saveImageAction() {
    }
    
}

// MARK: - Private Constants
private extension TableViewCell {
    enum Constants {
        enum MainView {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
            static let radius: CGFloat = 8
        }

        enum CounterLabel {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -10
            static let leading: CGFloat = 16
            static let width: CGFloat = 35
        }
        
        enum DescriptionLabel {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -14
            static let bottom: CGFloat = -9
        }
        
        enum CounterStepper {
            static let tailing: CGFloat = -14
            static let bottom: CGFloat = -14
        }
        
        enum DividerView {
            static let width: CGFloat = 2
        }
    }
    
    enum Font {
        enum Counter {
            static let size : CGFloat = 22
            static let bold = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
        
        enum Description {
            static let regular = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
}

// MARK: - Private Implementation
private extension TableViewCell {
    func setup() {
        setupMainView()
        setupCounterLabel()
        setupDividerView()
        setupDescriptionLabel()
        setupCounterStepper()
        setupHierarchy()
        setupConstraints()
    }

    func setupMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = Constants.MainView.radius
        mainView.backgroundColor = .white
    }
    
    func setupCounterLabel() {
        var font: UIFont = Font.Counter.bold
        if let descriptor = Font.Counter.bold.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: Font.Counter.size)
        }
        
        label.widthAnchor.constraint(equalToConstant: Constants.CounterLabel.width).isActive = true
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "99" // TODO: Binding
        label.textAlignment = .center
    }
    
    func setupDividerView() {
//        dividerView.translatesAutoresizingMaskIntoConstraints = false
//        dividerView.backgroundColor = .systemGray5
    }
    
    func setupDescriptionLabel() {
//        titleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Description.regular)
//        titleLabel.numberOfLines = 0
//        titleLabel.lineBreakMode = .byWordWrapping
//        titleLabel.textColor = UIColor(named: "DescriptionText")
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCounterStepper() {
//        countStepper.translatesAutoresizingMaskIntoConstraints = false
//        countStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    func setupHierarchy() {
        contentView.addSubview(mainView)
        mainView.addSubview(label)
        //mainView.addSubview(dividerView)
        //mainView.addSubview(titleLabel)
        //mainView.addSubview(countStepper)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.MainView.top),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.MainView.trailing),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MainView.leading),
            
            label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: Constants.CounterLabel.top),
            label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Constants.CounterLabel.trailing),
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.CounterLabel.leading),
            
            //            dividerView.widthAnchor.constraint(equalToConstant: Constants.DividerView.width),
            //            dividerView.topAnchor.constraint(equalTo: mainView.topAnchor),
            //            dividerView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: Constants.CounterLabel.trailing),
            //            dividerView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            //
            //            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: Constants.DescriptionLabel.top),
            //            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Constants.DescriptionLabel.trailing),
            //            titleLabel.bottomAnchor.constraint(equalTo: countStepper.topAnchor, constant: Constants.DescriptionLabel.bottom),
            //
            //            countStepper.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Constants.CounterStepper.tailing),
            //            countStepper.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: Constants.CounterStepper.bottom)
        ])
    }
}
