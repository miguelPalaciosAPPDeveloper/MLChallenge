//
//  OnboardingViewController.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 16/04/21.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingViewProtocol {
    // MARK: - @IBOUTLETS.
    @IBOutlet private weak var dotsBar: DotsbarView!
    @IBOutlet private weak var onboardingCollectionView: UICollectionView!
    @IBOutlet private weak var nextButton: UIMLButton!
    
    // MARK: - PROPERTIES.
    private var numberOfItems = 0
    var viewModel: OnboardingViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.didLoad()
    }
    
    // MARK: - SETUP FUNCTIONS.
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        dotsBar.backgroundColor = .clear
        setupCollectionView()
        setupButton()
        bind()
    }
    
    private func setupCollectionView() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.register(OnboardingViewCell.nib,
                                          forCellWithReuseIdentifier: OnboardingViewCell.reuseIdentifier)
        if let flowLayout = onboardingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        onboardingCollectionView.isPagingEnabled = true
    }
    
    private func setupButton() {
        nextButton.delegate = self
        nextButton.backgroundColor = .clear
    }
    
    // MARK: - PRIVATE FUNCTIONS.
    private func bind() {
        self.viewModel?.reloadTable = ({ [weak self] numberOfItems in
            self?.numberOfItems = numberOfItems
            self?.dotsBar.numberOfElements = numberOfItems
            self?.onboardingCollectionView.reloadData()
        })
        
        self.viewModel?.updateButton = ({ [weak self] title, hiddeIcon in
            self?.nextButton.titleLabel = title
            self?.nextButton.hiddeIcon = hiddeIcon
        })
        
        self.viewModel?.goToSiteSelector = ({ [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
    }
    
    private func selectedOnboardintItem(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        
        self.dotsBar.currentElement = index
        self.viewModel?.changeButton(at: index)
        self.onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: -UICOLLECTIONVIEWDELEGATE & UICOLLECTIONVIEWDATASOURCE IMPLEMENTATION.
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = self.viewModel?.getCellModel(at: indexPath.item) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath)
        
        (cell as? ViewCellConfigurable)?.setup(model)
        
        return cell
    }
}

// MARK: - UICOLLECTIONVIEWDELEGATEFLOWLAYOUT IMPLEMENTATION.
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let valueX = targetContentOffset.move().x / self.view.frame.width
        let index = Int(valueX)
        self.viewModel?.changeButton(at: index)
        self.dotsBar.currentElement = index
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset.x / onboardingCollectionView.frame.width
        self.dotsBar.moveSlideBar(point: point)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.onboardingCollectionView.frame.width,
                      height: self.onboardingCollectionView.frame.height)
    }
}

// MARK: - UIMLBUTTONDELEGATE IMPLEMENTATION.
extension OnboardingViewController: UIMLButtonDelegate {
    func action(_ buttonType: MLButtonType, sender: Any) {
        guard dotsBar.currentElement == numberOfItems - 1 else {
            self.dotsBar.currentElement = dotsBar.currentElement + 1
            self.selectedOnboardintItem(index: dotsBar.currentElement)
            return
        }
        self.viewModel?.didTapActionButton()
    }
}
