
import SwiftUI

@available(iOS 14.0, *)
struct UniqueSplash: View {
    
    @StateObject private var access = UniqueAccess()
    @State private var remoteURL: URL?
    @State private var showLoader = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            if remoteURL == nil && !showLoader {
                DashboardView().ignoresSafeArea()
            }
            
            if let url = remoteURL {
                UniqueWebView(url: url, loading: $showLoader)
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
            }
            
            if showLoader {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.8)
                    )
            }
        }
        .onReceive(access.$state) { s in
            switch s {
            case .validating:
                showLoader = true
            case .approved(_, let url):
                remoteURL = url
                showLoader = false
            case .native:
                remoteURL = nil
                showLoader = false
            case .idle:
                break
            }
        }
        .onAppear {
            showLoader = true
            access.start()
        }
    }
}
