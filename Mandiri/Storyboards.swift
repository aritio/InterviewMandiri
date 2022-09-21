//
//  Storyboards.swift
//

import Foundation
import UIKit

internal enum StoryboardScene {
    

    internal enum Main: StoryboardType {
        internal static let storyboardName = "Main"
        internal static let ViewController = SceneType<ViewController>(storyboard: Main.self, identifier: "ViewController")
    }
    
    internal enum Source: StoryboardType {
        internal static let storyboardName = "Source"
        internal static let CategoriesViewController = SceneType<CategoriesViewController>(storyboard: Source.self, identifier: "CategoriesViewController")
    }

    internal enum Artikel: StoryboardType {
        internal static let storyboardName = "Artikel"
        internal static let ArtikelViewController = SceneType<ArtikelViewController>(storyboard: Artikel.self, identifier: "ArtikelViewController")
    }
    
    internal enum Webview: StoryboardType {
        internal static let storyboardName = "Webview"
        internal static let WebViewViewController = SceneType<WebViewViewController>(storyboard: Webview.self, identifier: "WebViewViewController")
    }
}

internal protocol StoryboardType {
    static var storyboardName: String { get }
}

internal extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
    }
}

internal struct SceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    internal let identifier: String
    
    internal func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

internal struct InitialSceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    
    internal func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }
}

private final class BundleToken {}
