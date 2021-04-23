//
//  DotsbarView.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

class DotsbarView: UIView {
    // MARK: - IBOUTLETS.
    @IBOutlet private weak var dotsCollectionView: UICollectionView!
    @IBOutlet private weak var slideBarConstraint: NSLayoutConstraint!
    
    // MARK: - CONSTANTS.
    private typealias constants = GeneralConstants
    
    // MARK: - PROPERTIES.
    var numberOfElements: Int = 0 {
        didSet {
            self.dotsCollectionView.reloadData()
        }
    }
    
    var currentElement = 0 {
        didSet {
            self.dotsCollectionView.reloadData()
        }
    }
    
    // MARK: - INIT FUNCTIONS.
    override private init(frame: CGRect) {
      super.init(frame: frame)
        xibSetup()
    }

    public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func draw(_ rect: CGRect) {
        setupCollectionView()
    }
    
    // MARK: Setup functions.
    private func setupCollectionView() {
        dotsCollectionView.delegate = self
        dotsCollectionView.dataSource = self
        dotsCollectionView.isScrollEnabled = false
        dotsCollectionView.backgroundColor = .clear
        dotsCollectionView.register(DotViewCell.nib,
                                    forCellWithReuseIdentifier: DotViewCell.reuseIdentifier)
        if let flowLayout = dotsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0.0
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    func moveSlideBar(point: CGFloat) {
        let newConstant = (point * constants.defaultWidth) + constants.slideBarConstant
        let constant = newConstant == 0 ? constants.slideBarConstant : newConstant
        slideBarConstraint.constant = constant
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource implementation.
extension DotsbarView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfElements
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DotViewCell.reuseIdentifier, for: indexPath)
    }
}

// MARK: UICollectionViewDelegateFlowLayout implementation.
extension DotsbarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = indexPath.item == currentElement ? constants.widthSelected : constants.defaultWidth

        return CGSize(width: width,
                      height: self.frame.height)
    }
}
