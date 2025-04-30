import UIKit

class AccessibleSumViewController: UIViewController {

    // MARK: - UI Elements

    private lazy var number1Label: UILabel = {
        let label = UILabel()
        label.text = "Número 1:"
        label.textColor = UIColor.label // UI: Cor Semântica (Modo Escuro/Claro)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false // VoiceOver: Oculta label visual redundante
        return label
    }()

    private lazy var number1TextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite o primeiro número"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textColor = UIColor.label // UI: Cor Semântica
        textField.backgroundColor = UIColor.secondarySystemBackground // UI: Cor Semântica
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Acessibilidade configurada em setupAccessibility()
        return textField
    }()

    private lazy var number2Label: UILabel = {
        let label = UILabel()
        label.text = "Número 2:"
        label.textColor = UIColor.label // UI: Cor Semântica
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false // VoiceOver: Oculta label visual redundante
        return label
    }()

    private lazy var number2TextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite o segundo número"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textColor = UIColor.label // UI: Cor Semântica
        textField.backgroundColor = UIColor.secondarySystemBackground // UI: Cor Semântica
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Acessibilidade configurada em setupAccessibility()
        return textField
    }()

    private lazy var sumButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Somar", for: .normal)
        button.backgroundColor = .systemBlue // UI: Cor Semântica
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        // Acessibilidade configurada em setupAccessibility()
        return button
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.label // UI: Cor Semântica
        label.translatesAutoresizingMaskIntoConstraints = false
        // Acessibilidade configurada em setupAccessibility()
        return label
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialSetup()
        addSubviews()
        setupConstraints()
        setupActions()
        // Configurações específicas de acessibilidade
        setupAccessibility()
        setupDynamicType()
    }

    // MARK: - Setup Methods

    private func configureInitialSetup() {
        view.backgroundColor = .systemBackground // UI: Cor Semântica (Modo Escuro/Claro)
        self.title = "Soma Acessível"

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func addSubviews() {
        view.addSubview(number1Label)
        view.addSubview(number1TextField)
        view.addSubview(number2Label)
        view.addSubview(number2TextField)
        view.addSubview(sumButton)
        view.addSubview(resultLabel)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let horizontalPadding: CGFloat = 20
        let verticalSpacing: CGFloat = 15
        let textFieldHeight: CGFloat = 44 // UI: Altura mínima para toque

        // Ativação das constraints de Auto Layout
        NSLayoutConstraint.activate([
            // ... (constraints como na versão anterior) ...
            number1Label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: verticalSpacing * 2),
            number1Label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: horizontalPadding),
            number1Label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -horizontalPadding),

            number1TextField.topAnchor.constraint(equalTo: number1Label.bottomAnchor, constant: verticalSpacing / 2),
            number1TextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: horizontalPadding),
            number1TextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -horizontalPadding),
            number1TextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            number2Label.topAnchor.constraint(equalTo: number1TextField.bottomAnchor, constant: verticalSpacing),
            number2Label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: horizontalPadding),
            number2Label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -horizontalPadding),

            number2TextField.topAnchor.constraint(equalTo: number2Label.bottomAnchor, constant: verticalSpacing / 2),
            number2TextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: horizontalPadding),
            number2TextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -horizontalPadding),
            number2TextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            sumButton.topAnchor.constraint(equalTo: number2TextField.bottomAnchor, constant: verticalSpacing * 2),
            sumButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sumButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            sumButton.heightAnchor.constraint(equalToConstant: textFieldHeight),

            resultLabel.topAnchor.constraint(equalTo: sumButton.bottomAnchor, constant: verticalSpacing * 2),
            resultLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: horizontalPadding),
            resultLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -horizontalPadding),
        ])
    }

    private func setupActions() {
        sumButton.addTarget(self, action: #selector(sumButtonTapped), for: .touchUpInside)
    }

    // MARK: - Accessibility Implementation

    // Configura elementos para VoiceOver e outras tecnologias assistivas.
    private func setupAccessibility() {
        // Configuração dos campos de texto para VoiceOver
        number1TextField.isAccessibilityElement = true
        number1TextField.accessibilityLabel = number1Label.text // VoiceOver: Rótulo descritivo
        number1TextField.accessibilityHint = "Digite o primeiro número para a soma" // VoiceOver: Dica de uso

        number2TextField.isAccessibilityElement = true
        number2TextField.accessibilityLabel = number2Label.text // VoiceOver: Rótulo descritivo
        number2TextField.accessibilityHint = "Digite o segundo número para a soma" // VoiceOver: Dica de uso

        // Configuração do botão para VoiceOver
        sumButton.isAccessibilityElement = true
        sumButton.accessibilityLabel = sumButton.title(for: .normal) // VoiceOver: Rótulo
        sumButton.accessibilityHint = "Toque para calcular a soma dos dois números" // VoiceOver: Dica
        sumButton.accessibilityTraits = .button // VoiceOver: Define o tipo como botão

        // Configuração do label de resultado para VoiceOver
        resultLabel.isAccessibilityElement = true
        resultLabel.accessibilityLabel = "Resultado da soma" // VoiceOver: Rótulo
        resultLabel.accessibilityValue = "Nenhum resultado ainda" // VoiceOver: Valor inicial (será atualizado)
    }

    // Configura as fontes para suportar o ajuste dinâmico de tamanho do iOS.
    private func setupDynamicType() {
        // Aplica fontes que respondem às configurações de acessibilidade do usuário
        number1Label.font = UIFont.preferredFont(forTextStyle: .headline) // Dynamic Type: Fonte preferida
        number1Label.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste

        number1TextField.font = UIFont.preferredFont(forTextStyle: .body) // Dynamic Type: Fonte preferida
        number1TextField.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste

        number2Label.font = UIFont.preferredFont(forTextStyle: .headline) // Dynamic Type: Fonte preferida
        number2Label.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste

        number2TextField.font = UIFont.preferredFont(forTextStyle: .body) // Dynamic Type: Fonte preferida
        number2TextField.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste

        sumButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) // Dynamic Type: Fonte preferida
        sumButton.titleLabel?.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste
        sumButton.titleLabel?.numberOfLines = 1
        sumButton.titleLabel?.lineBreakMode = .byClipping

        resultLabel.font = UIFont.preferredFont(forTextStyle: .title1) // Dynamic Type: Fonte preferida
        resultLabel.adjustsFontForContentSizeCategory = true // Dynamic Type: Habilita ajuste
    }

    // MARK: - Actions

    @objc private func sumButtonTapped() {
        calculateSum()
        dismissKeyboard()
    }

    // MARK: - Logic

    private func calculateSum() {
        let text1 = number1TextField.text ?? ""
        let text2 = number2TextField.text ?? ""

        guard let number1 = Double(text1.replacingOccurrences(of: ",", with: ".")),
              let number2 = Double(text2.replacingOccurrences(of: ",", with: "."))
        else {
            resultLabel.text = "Erro: Insira números válidos."
            resultLabel.accessibilityValue = "Erro ao calcular" // VoiceOver: Atualiza valor com erro
            // Notifica o VoiceOver imediatamente sobre a mudança na tela (erro).
            UIAccessibility.post(notification: .screenChanged, argument: resultLabel)
            return
        }

        let sum = number1 + number2
        let resultString: String

        if floor(sum) == sum {
            resultString = String(format: "%.0f", sum)
        } else {
            resultString = String(format: "%.2f", sum)
        }

        resultLabel.text = "Resultado: \(resultString)"
        resultLabel.accessibilityValue = resultString // VoiceOver: Atualiza valor com resultado
        // Notifica o VoiceOver imediatamente sobre a mudança na tela (novo resultado).
        UIAccessibility.post(notification: .screenChanged, argument: resultLabel)
    }
}
