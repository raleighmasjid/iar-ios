//
//  MockData.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

#if DEBUG

import Foundation
import Combine
import CoreLocation

class MockAlmostValidLocationProvider: LocationProvider {
    weak var delegate: LocationProviderDelegate?
    
    func startUpdating() {
        self.delegate?.didUpdateHeading(Heading(direction: 64.0, accuracy: 3), location: CLLocation(latitude: 35.791836480187186, longitude: -78.6350442338134), authorizationStatus: .authorizedWhenInUse)
    }
    
    func stopUpdating() {
        
    }
    
    func requestLocationAccess() {
        
    }
    
    func requestFullAccuracy() {
        
    }
    
    var headingAvailable: Bool {
        true
    }
    
    var accuracyAuthorization: CLAccuracyAuthorization {
        .reducedAccuracy
    }
}

class MockDeniedLocationProvider: LocationProvider {
    weak var delegate: LocationProviderDelegate?
    
    func startUpdating() {
        self.delegate?.didUpdateHeading(nil, location: nil, authorizationStatus: .denied)
    }
    
    func stopUpdating() {
        
    }
    
    func requestLocationAccess() {
        
    }
    
    func requestFullAccuracy() {
        
    }
    
    var headingAvailable: Bool {
        true
    }
    
    var accuracyAuthorization: CLAccuracyAuthorization {
        .reducedAccuracy
    }
}

class MockUnavailableLocationProvider: LocationProvider {
    weak var delegate: LocationProviderDelegate?
    
    func startUpdating() {
        self.delegate?.didUpdateHeading(nil, location: nil, authorizationStatus: .denied)
    }
    
    func stopUpdating() {
        
    }
    
    func requestLocationAccess() {
        
    }
    
    func requestFullAccuracy() {
        
    }
    
    var headingAvailable: Bool {
        false
    }
    
    var accuracyAuthorization: CLAccuracyAuthorization {
        .reducedAccuracy
    }
}


class MockLocationProvider: LocationProvider {
    weak var delegate: LocationProviderDelegate?
    
    func startUpdating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.delegate?.didUpdateLocation("Raleigh")
            self.delegate?.didUpdateHeading(Heading(direction: 13.0, accuracy: 3), location: CLLocation(latitude: 35.791836480187186, longitude: -78.6350442338134), authorizationStatus: .authorizedWhenInUse)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.delegate?.didUpdateHeading(Heading(direction: 55.0, accuracy: 3), location: CLLocation(latitude: 35.791836480187186, longitude: -78.6350442338134), authorizationStatus: .authorizedWhenInUse)
//                self.delegate?.didUpdateHeading(Heading(direction: 145.0, accuracy: 3), location: CLLocation(latitude: 35.791836480187186, longitude: -78.6350442338134), authorizationStatus: .authorizedWhenInUse)
            }
        }
    }
    
    func stopUpdating() {
        
    }
    
    func requestFullAccuracy() {
        
    }
    
    func requestLocationAccess() {
        
    }
    
    var headingAvailable: Bool {
        true
    }
    
    var accuracyAuthorization: CLAccuracyAuthorization {
        .reducedAccuracy
    }
}

class MockProvider: PrayerProvider, NewsProvider {
    static var mockNews: News {
        News.mocks()
    }
    
    static var mockPrayerSchedule: PrayerSchedule {
        let days: [PrayerDay] = [.mock(), .mock(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)]
        return PrayerSchedule(prayerDays: days, fridaySchedule: FridayPrayer.mocks())
    }
    
    var cachedNews: News? = MockProvider.mockNews
    
    @MainActor
    func fetchNews(forceRefresh: Bool) async throws -> News {
        return MockProvider.mockNews
    }
    
    var cachedPrayerSchedule: PrayerSchedule? = MockProvider.mockPrayerSchedule
    
    @MainActor
    func fetchPrayers(forceRefresh: Bool) async throws -> PrayerSchedule {
        return MockProvider.mockPrayerSchedule
    }
}

extension News {
    static func mocks() -> News {
        let json = #"""
        {
          "announcements": {
            "special": {
              "id": 11734,
              "title": "COVID-19 Restrictions in place for now and for the foreseeable future ever and ever",
              "date": "2022-01-02T11:57:16-05:00",
              "url": "https://raleighmasjid.org/special-covid-19-restriction/",
              "text": "unorganized activities lorem ipsum dolor sit amet. The third shift will NOT be held due to the inclement weather. No activities.",
              "image": null
            },
            "posts": [
              {
                "id": 1736,
                "title": "Clubs and Sessions for Our Youth",
                "date": "2022-03-03T11:18:25-05:00",
                "url": "https://raleighmasjid.org/clubs_and_sessions_for_our_you/",
                "text": "The Youth Committee at the IAR is offering a wide variety of Clubs & Sessions for our youth. So far we have Adhan & Iqamah Club, Science Club, Technology Club and career club.  Generally all clubs and sessions require registration and are 6 weeks long from 6:30pm to 8:00pm with breaks for Salah. Youth will have the opportunity to network with other youth and with our professional community members while gaining a skill. Our goal is to offer more Clubs & Sessions as they become available.\nMore information & registration",
                "image": null
              },
              {
                "id": 12536,
                "title": "IAR Statement and FAQs on Imam AbuTaleb’s resignation",
                "date": "2022-02-21T16:40:59-05:00",
                "url": "https://raleighmasjid.org/iar-statement-on-imam-abutalebs-resignation/",
                "text": "The Islamic Association of Raleigh regrets to inform our community members that Imam Abutaleb has resigned from his position as Imam due to personal reasons.  The IAR is grateful for…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2022/02/@raleighmasjid-3.png"
              },
              {
                "id": 12477,
                "title": "Hajj 2022/1443 – Pre-Registration is now Live!",
                "date": "2022-02-14T15:16:50-05:00",
                "url": "https://raleighmasjid.org/hajj-2022-1443-pre-registration-is-now-live/",
                "text": "Your Hajj Team is working diligently to secure our IAR package for Hajj 2022/1443. The Hajj 2022 Pre-Registration is now live at IARHajj.org. Please note the following points from our Hajj partners: (1) There has…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2022/02/hajjflyer.jpg"
              },
              {
                "id": 11838,
                "title": "3rd Jumu’ah Shift CANCELLED",
                "date": "2022-01-21T09:42:35-05:00",
                "url": "https://raleighmasjid.org/special-covid-19-restriction-copy/",
                "text": "The IAR will hold 2 shifts for Jumuah (Friday) prayers at 11:30am and 1:00pm. The third shift will NOT be held due to the inclement weather. No activities except prayers…",
                "image": null
              },
              {
                "id": 11619,
                "title": "Strategic Plan",
                "date": "2021-12-12T15:20:37-05:00",
                "url": "https://raleighmasjid.org/strategic-plan/",
                "text": "Strategic Plan 2019 Table of Contents Introduction Frequently Asked Questions Strategic Planning Process Mission, Vision , Core Values and Focus Areas Summary and Analysis of previous 5 year plan Current…",
                "image": null
              },
              {
                "id": 11384,
                "title": "Amazon Smile",
                "date": "2021-11-24T14:18:52-05:00",
                "url": "https://raleighmasjid.org/amazon-smile/",
                "text": "Support your masjid while you shop for everyday essentials! Choose the Islamic Association of Raleigh on Amazon Smile today. What is AmazonSmile? AmazonSmile is a simple way for you to…",
                "image": null
              },
              {
                "id": 9744,
                "title": "SuperMoms Meet & Greet Event",
                "date": "2021-10-27T20:57:29-04:00",
                "url": "https://raleighmasjid.org/supermoms-meet-greet-event/",
                "text": "Do you have a child with special needs? Come join SuperMoms at a Meet & Greet event on Saturday, November 13th at 1:00 PM at The Museum of Art park.",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/10/WhatsApp-Image-2021-10-25-at-7.40.27-PM-2.jpeg"
              },
              {
                "id": 8719,
                "title": "September at IAR",
                "date": "2021-09-08T21:27:51-04:00",
                "url": "https://raleighmasjid.org/september-at-iar/",
                "text": "Your masjid has a variety of exciting events coming up this month! Click through to check them all out. Quran and Tajweed (TBD) Imam Badawy teaches a Quran recitation class…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/09/This-Month-at-IAR-4.png"
              },
              {
                "id": 8033,
                "title": "HS Girls Hangout & Halaqa",
                "date": "2021-08-25T16:10:48-04:00",
                "url": "https://raleighmasjid.org/hs-girls/",
                "text": "Join us every Friday for our HS Girls Hangout and Halaqa from 7:30 PM to 9 PM in the Sister’s Musallah. Register now!",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/2-37.jpg"
              },
              {
                "id": 7420,
                "title": "Want to get your hands dirty?",
                "date": "2021-08-12T06:46:46-04:00",
                "url": "https://raleighmasjid.org/want-to-get-your-hands-dirty/",
                "text": "Your Masjid’s Maintenance department is seeking volunteers to help with their long-term goals and projects. Any amount of time you can contribute and all skill levels are welcomed! if you are…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/08/header-background-1.jpg"
              },
              {
                "id": 7336,
                "title": "Anxious or excited about in-person school?",
                "date": "2021-08-06T10:59:50-04:00",
                "url": "https://raleighmasjid.org/anxious-or-excited-about-in-person-school/",
                "text": "Now that schools are opening up, is your child excited or anxious at this change? What are some ways that parents and educators can make the transition easier for kids?…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/08/img_2262.jpg"
              },
              {
                "id": 7333,
                "title": "Join MIST!",
                "date": "2021-08-06T10:55:31-04:00",
                "url": "https://raleighmasjid.org/join-mist/",
                "text": "Are you a college-level individual? Looking for a volunteer opportunity? Join MIST! MIST Carolina is officially recruiting for the 2022 Board. MIST stands for Muslim InterScholastic Tournament, an annual weekend…",
                "image": null
              },
              {
                "id": 7122,
                "title": "Calling all Artists!",
                "date": "2021-07-29T14:21:16-04:00",
                "url": "https://raleighmasjid.org/calling-all-artists/",
                "text": "Insha Allah under the SABR (Sisters and Brothers Rising) Committee of IAR and invite you all to participate. We will be transforming the IAR gym area for the festival and it…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/TIFA-Flyer.jpg"
              },
              {
                "id": 7117,
                "title": "Move The Tassel: Celebrating Recent Graduates",
                "date": "2021-07-29T03:06:54-04:00",
                "url": "https://raleighmasjid.org/move-the-tassel-celebrating-recent-graduates/",
                "text": "Triangle Muslims is pleased to invite you to Move the Tassel – A Time to Celebrate. This event is for high school, college, and hifdh graduates of the triangle to…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/MTT-1.png"
              },
              {
                "id": 6559,
                "title": "Qur’an Night on Friday 7-30",
                "date": "2021-07-26T21:03:39-04:00",
                "url": "https://raleighmasjid.org/quran-night-on-friday-7-30/",
                "text": "See flyer",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/quran-night-7-30.png"
              },
              {
                "id": 6517,
                "title": "Autism and ADHD in Youth Webinar",
                "date": "2021-07-23T18:54:39-04:00",
                "url": "https://raleighmasjid.org/autism-and-adhd-in-youth-webinar/",
                "text": "Are you wondering about signs and symptoms in your children? Is your child already diagnosed and you would like more information? Do you just want to learn more about common…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/AUTISM-AND-ADHD-IN-YOUTH.png"
              },
              {
                "id": 6221,
                "title": "Eid ul Adha Volunteers",
                "date": "2021-07-16T23:05:41-04:00",
                "url": "https://raleighmasjid.org/eid-ul-adha-volunteers/",
                "text": "Your masjid is seeking volunteers on July 19 and 20 to help set up the hall and facilitate Eid day. Eid ul Adha will be held at the Exposition Center…",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/unnamed.jpg"
              },
              {
                "id": 4223,
                "title": "Brothers’ Basketball League",
                "date": "2021-07-01T13:26:31-04:00",
                "url": "https://raleighmasjid.org/college-up-basketball-tournament/",
                "text": "IAR Youth is excited to announce a 10-week basketball league for brothers 16 and up! Games will be held every Tuesday and Thursday evenings starting August 3rd! Register here.",
                "image": "https://raleighmasjid.org/wp-content/uploads/2021/07/IMG_8352.jpg"
              },
              {
                "id": 3727,
                "title": "Job Opening: Part-Time Language Arts and Social Studies Teacher",
                "date": "2021-06-27T04:33:25-04:00",
                "url": "https://raleighmasjid.org/job-opening-part-time-language-arts-and-social-studies-teacher/",
                "text": "An-Noor is seeking a part-time Language Arts and Social Studies teacher for 7th and 8th grade.",
                "image": null
              },
              {
                "id": 2580,
                "title": "Al- Furqan School Registration 2021-2022",
                "date": "2021-06-07T23:34:44-04:00",
                "url": "https://raleighmasjid.org/al-furqan-school-registration-2021-2022/",
                "text": "Registration for Al-Furqan School 2021-2022 is now open. Online registration can be completed via the website alfurqanschool.com. In addition to the already discounted fees, there’s a 10% early bird registration…",
                "image": null
              }
            ],
            "featured": {
              "id": 12811,
              "title": "Ustadh Ekram Haque visit on Friday 3-18",
              "date": "2022-03-18T07:47:35-04:00",
              "url": "https://raleighmasjid.org/ustadh-ekram-haque-visit-on-friday-3-18/",
              "text": "IAR Welcoming Guest Speaker Ustadh Ekram Haque this Friday 3/18. He will give 2nd Khutbah at 1:00 PM and will also give a lecture on Friday night after Maghrib.",
              "image": "https://raleighmasjid.org/wp-content/uploads/2022/03/IMG-20220316-WA0026.jpg"
            }
          },
          "events": [
            {
              "id": 5429,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism/2022-03-20/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-20T00:00:00-04:00",
              "end": "2022-03-20T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 7783,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism-2021-01-10/2022-03-20/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-20T00:00:00-04:00",
              "end": "2022-03-20T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 4883,
              "title": "Introduction to Islam",
              "url": "https://raleighmasjid.org/program/introduction-to-islam/2022-03-20/",
              "description": "Learn about Islam online from the comfort of your home! Due to COVID-19, we're now holding online classes instead of the in-person class. We invite you to participate live either…",
              "start": "2022-03-20T14:00:00-04:00",
              "end": "2022-03-20T15:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 10080,
              "title": "High School Girls’ Halaqa and Hangout",
              "url": "https://raleighmasjid.org/program/sisters-high-school-halaqah/2022-03-20/",
              "description": "Audience: High School Sisters Timing: Sundays from 2-4 PM Location: Sisters' Musallah (glass room) Click here for Registration & More Info.",
              "start": "2022-03-20T14:00:00-04:00",
              "end": "2022-03-20T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 9264,
              "title": "Ummi and Me: Storytime for Children",
              "url": "https://raleighmasjid.org/program/ummi-and-me-storytime-for-children/2022-03-23/",
              "description": "Join us for story time at Ummi and Me! The youngest members of our community (ages 0 - 5) are invited to attend with their caregivers. Activities include story time,…",
              "start": "2022-03-23T10:30:00-04:00",
              "end": "2022-03-23T12:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 12703,
              "title": "Youth Day 2022: Back to My Masjid",
              "url": "https://raleighmasjid.org/program/youthday/",
              "description": "REGISTER VOLUNTEER Youth Day, one of the most prized traditions in the 37-year history of the IAR, is back! Come out with your friends for the largest Muslim youth event…",
              "start": "2022-03-26T12:00:00-04:00",
              "end": "2022-03-26T20:00:00-04:00",
              "all_day": false,
              "repeating": false
            },
            {
              "id": 4684,
              "title": "Elementary & Middle School Boys Saturday Program",
              "url": "https://raleighmasjid.org/program/elementary-middle-school-boys-saturday-program/2022-03-26/",
              "description": "Audience: Elementary & Middle School Boys Timing: Saturdays at 2 PM Registration & Contact: Mahen Khan - mahenmkhan@gmail.com",
              "start": "2022-03-26T14:00:00-04:00",
              "end": "2022-03-26T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 12122,
              "title": "Girls Saturday Program",
              "url": "https://raleighmasjid.org/program/girls-saturday-program/2022-03-26/",
              "description": "Visit the program page for up to date information and registration. Audience: Elementary, Middle, & High School Sisters Contact: Sr. Farrah Khan - farrah.khan@iaryouth.org",
              "start": "2022-03-26T14:00:00-04:00",
              "end": "2022-03-26T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 8374,
              "title": "High School Boys’ Night",
              "url": "https://raleighmasjid.org/program/brothers-high-school-halaqah-2021-01-09/2022-03-26/",
              "description": "High school brothers are invited to join their fellow youth for a weekly hangout featuring sports, video games, and an uplifting reminder followed by dinner. This program is an opportunity…",
              "start": "2022-03-26T19:00:00-04:00",
              "end": "2022-03-26T23:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 5431,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism/2022-03-27/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-27T00:00:00-04:00",
              "end": "2022-03-27T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 7784,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism-2021-01-10/2022-03-27/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-27T00:00:00-04:00",
              "end": "2022-03-27T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 4884,
              "title": "Introduction to Islam",
              "url": "https://raleighmasjid.org/program/introduction-to-islam/2022-03-27/",
              "description": "Learn about Islam online from the comfort of your home! Due to COVID-19, we're now holding online classes instead of the in-person class. We invite you to participate live either…",
              "start": "2022-03-27T14:00:00-04:00",
              "end": "2022-03-27T15:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 10081,
              "title": "High School Girls’ Halaqa and Hangout",
              "url": "https://raleighmasjid.org/program/sisters-high-school-halaqah/2022-03-27/",
              "description": "Audience: High School Sisters Timing: Sundays from 2-4 PM Location: Sisters' Musallah (glass room) Click here for Registration & More Info.",
              "start": "2022-03-27T14:00:00-04:00",
              "end": "2022-03-27T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 9265,
              "title": "Ummi and Me: Storytime for Children",
              "url": "https://raleighmasjid.org/program/ummi-and-me-storytime-for-children/2022-03-30/",
              "description": "Join us for story time at Ummi and Me! The youngest members of our community (ages 0 - 5) are invited to attend with their caregivers. Activities include story time,…",
              "start": "2022-03-30T10:30:00-04:00",
              "end": "2022-03-30T12:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 4685,
              "title": "Elementary & Middle School Boys Saturday Program",
              "url": "https://raleighmasjid.org/program/elementary-middle-school-boys-saturday-program/2022-04-02/",
              "description": "Audience: Elementary & Middle School Boys Timing: Saturdays at 2 PM Registration & Contact: Mahen Khan - mahenmkhan@gmail.com",
              "start": "2022-04-02T14:00:00-04:00",
              "end": "2022-04-02T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 12124,
              "title": "Girls Saturday Program",
              "url": "https://raleighmasjid.org/program/girls-saturday-program/2022-04-02/",
              "description": "Visit the program page for up to date information and registration. Audience: Elementary, Middle, & High School Sisters Contact: Sr. Farrah Khan - farrah.khan@iaryouth.org",
              "start": "2022-04-02T14:00:00-04:00",
              "end": "2022-04-02T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 8375,
              "title": "High School Boys’ Night",
              "url": "https://raleighmasjid.org/program/brothers-high-school-halaqah-2021-01-09/2022-04-02/",
              "description": "High school brothers are invited to join their fellow youth for a weekly hangout featuring sports, video games, and an uplifting reminder followed by dinner. This program is an opportunity…",
              "start": "2022-04-02T19:00:00-04:00",
              "end": "2022-04-02T23:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 5433,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism/2022-04-03/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-04-03T00:00:00-04:00",
              "end": "2022-04-03T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 7785,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism-2021-01-10/2022-04-03/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-04-03T00:00:00-04:00",
              "end": "2022-04-03T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 4885,
              "title": "Introduction to Islam",
              "url": "https://raleighmasjid.org/program/introduction-to-islam/2022-04-03/",
              "description": "Learn about Islam online from the comfort of your home! Due to COVID-19, we're now holding online classes instead of the in-person class. We invite you to participate live either…",
              "start": "2022-04-03T14:00:00-04:00",
              "end": "2022-04-03T15:00:00-04:00",
              "all_day": false,
              "repeating": true
            }
          ]
        }
        """#
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(News.self, from: json.data(using: .utf8)!)
    }
}

extension FridayPrayer {
    static func mocks() -> [FridayPrayer] {
        let json = """
        [
            {
              "title": "How Can I Help to Convey the Message of Islam Lorem Ipsum Dolor Sit Amet How Can I Help to Convey the Message of Islam Lorem Ipsum Dolor Sit Amet",
              "shift": "1st Shift",
              "time": "11:30",
              "speaker": "Imam Mohamed Badawy Ibn Rasheed Ibn Fadlan Ibn Ahmed",
              "description": "Religious Specialist - Imam at Islamic Association of Raleigh",
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/badawy-logo.jpg"
            },
            {
              "title": "Da`wah: An Important Duty in Islam",
              "shift": "2nd Shift",
              "time": "1:00",
              "speaker": "Fiaz Fareed",
              "description": "Chairman of Outreach & Da'wah at IAR",
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/brother-fiaz-fareed-smaller.png"
            },
            {
              "title": "Islam: What the World Needs",
              "shift": "3rd Shift",
              "time": "2:15",
              "speaker": "Mohammed Hannini",
              "description": "Islamic Sciences Instructor",
              "image_url": ""
            },
            {
              "title": "Just an announcement",
              "shift": "",
              "time": "",
              "speaker": "",
              "description": "",
              "image_url": ""
            }
          ]
        """
        return try! JSONDecoder().decode([FridayPrayer].self, from: json.data(using: .utf8)!)
    }
}

extension PrayerDay {
    static func mock(date: Date = Date()) -> PrayerDay {
        let hijri = HijriComponents(monthName: "Ramadan", day: 23, year: 1443, month: 9)
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        var fajr = comps
        fajr.hour = 5
        fajr.minute = 38
        var shuruq = comps
        shuruq.hour = 6
        shuruq.minute = 45
        var dhuhr = comps
        dhuhr.hour = 12
        dhuhr.minute = 24
        var asr = comps
        asr.hour = 15
        asr.minute = 11
        var maghrib = comps
        maghrib.hour = 20
        maghrib.minute = 36
        var isha = comps
        isha.hour = 21
        isha.minute = 4
        
        let fajrDate = Calendar.current.date(from: fajr)!
        let shuruqDate = Calendar.current.date(from: shuruq)!
        let dhuhrDate = Calendar.current.date(from: dhuhr)!
        let asrDate = Calendar.current.date(from: asr)!
        let maghribDate = Calendar.current.date(from: maghrib)!
        let ishaDate = Calendar.current.date(from: isha)!
        
        let iqamah = IqamahSchedule(fajr: fajrDate.addingTimeInterval(600),
                                    dhuhr: dhuhrDate.addingTimeInterval(600),
                                    asr: asrDate.addingTimeInterval(600),
                                    maghrib: maghribDate.addingTimeInterval(600),
                                    isha: ishaDate.addingTimeInterval(600),
                                    taraweeh: nil)
        let adhan = AdhanSchedule(fajr: fajrDate,
                                  shuruq: shuruqDate,
                                  dhuhr: dhuhrDate,
                                  asr: asrDate,
                                  maghrib: maghribDate,
                                  isha: ishaDate)
        return PrayerDay(date: date, hijri: hijri, adhan: adhan, iqamah: iqamah)
    }
}

#endif
