//
//  EmojiTextField.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/08/11.
//

import SwiftUI

class EmojiTextField: UITextField {
    override var textInputContextIdentifier: String? { "" }

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes where mode.primaryLanguage == "emoji" {
            return mode
        }
        return nil
    }

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }

    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

/// 絵文字だけが 1 文字だけ入力できる TextField
/// キーボードも絵文字用になる
struct OneEmojiTextField: UIViewRepresentable {
    @Binding var inputText: String
    let fontSize: CGFloat

    func makeUIView(context: Context) -> UITextField {
        let textField = EmojiTextField()
        textField.font = .systemFont(ofSize: fontSize)
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}
}

extension OneEmojiTextField {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: OneEmojiTextField

        init(_ control: OneEmojiTextField) {
            self.parent = control
            super.init()
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            guard let profileImageEmoji = textField.text else { return }

            let emojiText = String(profileImageEmoji.onlyEmoji().prefix(1))
            textField.text = emojiText
            parent.inputText = emojiText
        }
    }
}
