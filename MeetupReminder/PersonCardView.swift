//
//  PersonCardView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct PersonCardView: View {
    let person: Person
    @Environment(\.openURL) var openURL

    var body: some View {
        Button(action: {
            // TODO: 詳細画面へ遷移
        }) {
            HStack(spacing: 20) {
                profileImage
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(person.name)
                                .foregroundColor(.mainText)
                                .font(.title)
                            Spacer()
                        }
                        Text(person.remark)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    contactList
                }
            }
        }
        .padding()
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color.cardViewBlue)
        .cornerRadius(20)
    }
}

private extension PersonCardView {
    var profileImage: some View {
        VStack {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(maxWidth: 60, maxHeight: 60)
            Spacer()
        }
    }

    var contactList: some View {
        HStack(spacing: 10) {
            Spacer()
            Button(action: {
                openURL(URL(string: "https://line.me/R/")!)
            }) {
                Image("line_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
            }
            Button(action: {
                openURL(URL(string: "fb://")!)
            }) {
                Image("facebook_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
            }
            Button(action: {
                openURL(URL(string: "twitter://")!)
            }) {
                Image("twitter_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
            }
            Button(action: {
                openURL(URL(string: "linkedin://")!)
            }) {
                Image("linkedin_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
            }
            Button(action: {
                openURL(URL(string: "slack://")!)
            }) {
                Image("slack_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
            }
        }
    }
}

struct PersonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCardView(person: Person(name: "加藤花子", canContactWithLINE: true, canContactWithFacebook: true, canContactWithTwitter: true, canContactWithLinkedIn: true, canContactWithSlack: true, remark: "try! Swiftで会った。iOSエンジニアとしては珍しく女性なので定期的に連絡を取りたい。"))
    }
}
