//
//  BookCollectionViewCell.swift
//  RecipeBook
//
//  Created by Pavel Schulepov on 11.07.2022.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "bookCell"
    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    private lazy var radiusView = bounds.height / 10
    var viewModel: BookCellViewModelType? {
        willSet(viewModel) {
            nameLabel.text = viewModel?.name
            imageView.image = viewModel?.image
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        nameLabel.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    private func createUI() {
        
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.sizeToFit()
        
        for i in [imageView, nameLabel] {
            i.translatesAutoresizingMaskIntoConstraints = false
            addSubview(i)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: radiusView),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -radiusView)
        ])
        
        imageView.layer.cornerRadius = radiusView
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.backgroundColor = isSelected ? .gray : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
    }
    
}
