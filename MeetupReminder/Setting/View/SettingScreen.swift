//
//  SettingScreen.swift
//  PomodoroCounter
//
//  Created by mikaurakawa on 2023/02/12.
//

import SwiftUI
import AppInfoList

struct SettingScreen<ViewModel: SettingViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    private let admobInterstitialCoordinator = AdmobInterstitialCoordinator()

    var body: some View {
        NavigationView {
            AppInfoListView(
                appearance: AppInfoAppearance(
                    cellTextColor: .mainText,
                    versionTextColor: .mainText,
                    cellTitles: CellTitles(termsOfUse: "利用規約・プライバシーポリシー")
                ),
                info: AppInfo(
                    termOfUseURL: URL(string: "https://kamimi01.github.io/MeetupReminder/privacy_policy/ja.html")!,
                    appURL: URL(string: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8C%E3%81%BE%E3%81%AD/id1668244395?l=ja")!,
                    developerInfoURL: URL(string: "https://twitter.com/kamimi_01")!,
                    appStoreID: "1668244395"
                ),
                licenseFileURL: Bundle.main.url(forResource: "license-list", withExtension: "plist")!
            )
            .navigationTitle("アプリについて")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    dismissButton
                }
            }
        }
        .background {
            adViewControllerRepresentable
                .frame(width: .zero, height: .zero)
        }
        .accentColor(.mainText)
        .onAppear {
            viewModel.onAppear()
            Task {
                // インタースティシャル広告の読み込みが終わるまで待つので1秒待機
                try await Task.sleep(nanoseconds: 1_000_000_000)
                admobInterstitialCoordinator.presentAd(from: adViewControllerRepresentable.viewController)
            }
        }
    }
}

// MARK: - Private Properties and Methods

private extension SettingScreen {
    var dismissButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "multiply")
                .foregroundColor(.mainText)
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen(viewModel: SettingViewModel())
    }
}
