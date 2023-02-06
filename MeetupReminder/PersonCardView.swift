//
//  PersonCardView.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/01/25.
//

import SwiftUI

struct PersonCardView: View {
    let person: PersonModel
    let cardColor: CardViewColor
    @Environment(\.openURL) var openURL

    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 20) {
                profileImage
                VStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(person.name)
                                .foregroundColor(cardColor.cardViewText)
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(person.remark)
                            .foregroundColor(.mainText)
                            .font(.callout)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(height: 90)
                    contactList
                }
            }
            .padding(16)
            HStack {
                cardColor.cardViewText
                    .frame(width: 8)
                Spacer()
            }
        }
        .frame(height: 170)
        .frame(maxWidth: .infinity)
        .background(cardColor.carViewBackground)
        .cornerRadius(20)
    }
}

private extension PersonCardView {
    var profileImage: some View {
        VStack {
            Image(cardColor.profileImage)
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
            if person.canContactWithLINE {
                Button(action: {
                    openURL(URL(string: "https://line.me/R/")!)
                }) {
                    Image(cardColor.lineImageFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                }
            }
            if person.canContactWithFacebook {
                Button(action: {
                    openURL(URL(string: "fb://")!)
                }) {
                    Image(cardColor.facebookImageFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                }
            }
            if person.canContactWithTwitter {
                Button(action: {
                    openURL(URL(string: "twitter://")!)
                }) {
                    Image(cardColor.twitterImageFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                }
            }
            if person.canContactWithLinkedIn {
                Button(action: {
                    openURL(URL(string: "linkedin://")!)
                }) {
                    Image(cardColor.linkedinImageFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                }
            }
            if person.canContactWithSlack {
                Button(action: {
                    openURL(URL(string: "slack://")!)
                }) {
                    Image(cardColor.slackImageFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                }
            }
        }
    }
}

struct PersonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCardView(person: createDummyData(), cardColor: CardViewColor.red)
    }

    static func createDummyData() -> PersonModel {
        let person = PersonModel(id: "", name: "加藤花子", canContactWithLINE: false, canContactWithFacebook: false, canContactWithTwitter: false, canContactWithLinkedIn: false, canContactWithSlack: false, remark: "", remindDate: nil)
        return person
    }
}
