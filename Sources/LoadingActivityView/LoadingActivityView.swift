import UIKit

struct LoadingActivityConfiguration {
    let message: String
    let font: UIFont
    /// The layout direction of the view
    let axis: NSLayoutConstraint.Axis
    /// The spacing between the spinner and text
    let spacing: CGFloat
    /// A value between 0.0 and 1.0
    let overlayOpacity: CGFloat
    let textColor: UIColor
    let indicatorStyle: UIActivityIndicatorView.Style = .white
}

final class LoadingActivityView: UIView {
    private let stackViewPadding = CGSize(width: 65, height: 40)
    private let visualEffectViewPadding: CGFloat = -40
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    init(frame: CGRect, configuration: LoadingActivityConfiguration) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(configuration.overlayOpacity)
        
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.style = configuration.indicatorStyle
        loadingIndicator.startAnimating()
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = configuration.axis
        stackView.alignment = .center
        stackView.spacing = configuration.spacing
        
        stackView.addArrangedSubview(loadingIndicator)
        
        messageLabel.text = configuration.message
        messageLabel.textColor = configuration.textColor
        
        let labelWrapper = UIView()
        labelWrapper.translatesAutoresizingMaskIntoConstraints = false
        labelWrapper.addSubview(messageLabel)
        
        messageLabel.leadingAnchor.constraint(equalTo: labelWrapper.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: labelWrapper.trailingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: labelWrapper.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: labelWrapper.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(labelWrapper)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.contentView.addSubview(stackView)
        visualEffectView.layer.cornerRadius = 12
        visualEffectView.clipsToBounds = true
        
        addSubview(visualEffectView)
        
        visualEffectView.heightAnchor.constraint(equalTo: stackView.heightAnchor,
                                                 constant: stackViewPadding.height).isActive = true
        
        visualEffectView.widthAnchor.constraint(equalTo: stackView.widthAnchor,
                                                constant: stackViewPadding.width).isActive = true
        
        visualEffectView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor,
                                                constant: visualEffectViewPadding).isActive = true
        
        visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        visualEffectView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
