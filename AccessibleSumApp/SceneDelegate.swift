import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. Garante que a cena é uma UIWindowScene. Se não for, não faz nada.
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 2. Cria a janela principal (UIWindow) com o tamanho da tela da cena.
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)

        // 3. Associa a cena à janela.
        window?.windowScene = windowScene

        // 4. Cria uma instância do teu ViewController principal (programático).
        //    Certifica-te que o nome aqui é exatamente o mesmo da tua classe ViewController.
        let rootViewController = AccessibleSumViewController()

        // (Opcional: Se quiseres uma barra de navegação no topo)
        // let navigationController = UINavigationController(rootViewController: rootViewController)
        // window?.rootViewController = navigationController // Define o Navigation Controller como raiz

        // Define o ViewController diretamente como raiz (sem barra de navegação)
        window?.rootViewController = rootViewController

        // 5. Torna a janela a janela principal e visível.
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Chamado quando a cena é libertada pelo sistema.
        // Isso geralmente acontece depois que a cena entra em segundo plano.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Chamado quando a cena passou de inativa para ativa.
        // Usa isto para reiniciar tarefas que foram pausadas (ou ainda não iniciadas) enquanto a cena estava inativa.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Chamado quando a cena está prestes a sair do estado ativo para o estado inativo.
        // Isso pode ocorrer devido a interrupções temporárias (ex: chamada telefónica recebida).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Chamado quando a cena transita de segundo plano para primeiro plano.
        // Usa isto para desfazer as alterações feitas ao entrar em segundo plano.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Chamado quando a cena transita de primeiro plano para segundo plano.
        // Usa isto para guardar dados, libertar recursos partilhados e guardar estado suficiente da cena
        // para restaurar o seu estado atual caso seja terminada posteriormente.
    }
}
