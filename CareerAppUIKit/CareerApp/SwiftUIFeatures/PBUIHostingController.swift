//
//  PBUIHostingController.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 24/04/25.
//

import SwiftUI

public protocol PBUIHostingControllerProtocol: UIViewController, PBTopBarProtocol {
    var statusBarStyle: UIStatusBarStyle { get set }
}

public protocol PBViewProtocol: View {
    func onViewDidLoad(_ viewController: PBUIHostingControllerProtocol)
    func onViewWillAppear(_ viewController: PBUIHostingControllerProtocol)
    func onViewDidAppear(_ viewController: PBUIHostingControllerProtocol)
    func onViewDidDisappear(_ viewController: PBUIHostingControllerProtocol)
}

open class PBUIHostingController<SUIView: PBViewProtocol>: UIHostingController<SUIHostView<SUIView>>, PBUIHostingControllerProtocol {
    public var statusBarStyle: UIStatusBarStyle = .default
    
    public let suiView: SUIView
    
    public init(view: SUIView) {
        self.suiView = view
        var controllerRef = SUIViewControllerWeakRef()
        super.init(rootView: SUIHostView(view: view, controllerRef: controllerRef))
        controllerRef.instance = self
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        assertionFailure()
        return nil
    }
    
    public func configureTopBar() {
        
    }
    
    public func updateTopBarButtonIndicator() {
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        suiView.onViewDidLoad(self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        suiView.onViewWillAppear(self)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        suiView.onViewDidAppear(self)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        suiView.onViewDidDisappear(self)
    }
}

public struct SUIHostView<T: PBViewProtocol>: View {
    let view: T
    fileprivate let controllerRef: SUIViewControllerWeakRef
    
    public var body: some View {
        view.environment(\.bridgeHostingController, controllerRef)
    }
}

private struct SUIViewControllerWeakRef {
    weak var instance: PBUIHostingControllerProtocol?
    
    init(instance: PBUIHostingControllerProtocol? = nil) {
        self.instance = instance
    }
}

private struct SUIViewControllerProtocolKey: EnvironmentKey {
    static let defaultValue: SUIViewControllerWeakRef? = nil
}


extension EnvironmentValues {
    public var hostingController: PBUIHostingControllerProtocol? {
        self[SUIViewControllerProtocolKey.self]?.instance
    }
    
    fileprivate var bridgeHostingController: SUIViewControllerWeakRef? {
        get { self[SUIViewControllerProtocolKey.self] }
        set { self[SUIViewControllerProtocolKey.self] = newValue }
    }
}
