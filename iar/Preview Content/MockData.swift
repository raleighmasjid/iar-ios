//
//  MockData.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

#if DEBUG

class MockProvider: PrayerProvider, NewsProvider {
    var cachedNews: News? = nil
    
    @MainActor
    func fetchNews() async throws -> News {
        return News.mocks()
    }
    
    var cachedPrayerSchedule: PrayerSchedule? = nil
    
    @MainActor
    func fetchPrayers() async throws -> PrayerSchedule {
        let days: [PrayerDay] = [.mock(), .mock(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)]
        return PrayerSchedule(prayerDays: days, fridaySchedule: FridayPrayer.mocks())
    }
}

extension News {
    static func mocks() -> News {
        let json = #"""
        {
          "special": {
            "id": 11734,
            "title": "Special COVID-19 Restriction",
            "date": "2022-01-02T11:57:16-05:00",
            "url": "https://raleighmasjid.org/special-covid-19-restriction/",
            "text": "Following the Wake County change in policy regarding COVID-19, the Islamic Association of Raleigh is lifting our mask mandate effective Friday, Feb 25th at 5 PM. Your masjid will continue to accommodate those that would like to social distance, and continue wearing their masks. Hand sanitizer stations will continue to be accessible to our community.\n\n\n\nAdditionally, the gym will be reopening for unorganized activities and community events. "
          },
          "announcements": [
            {
              "id": 1736,
              "title": "Clubs and Sessions for Our Youth",
              "date": "2022-03-03T11:18:25-05:00",
              "url": "https://raleighmasjid.org/clubs_and_sessions_for_our_you/",
              "text": "The Youth Committee at the IAR is offering a wide variety of Clubs & Sessions for our youth. So far we have Adhan & Iqamah Club, Science Club, Technology Club and career club.  Generally all clubs and sessions require registration and are 6 weeks long from 6:30pm to 8:00pm with breaks for Salah. Youth will have the opportunity to network with other youth and with our professional community members while gaining a skill. Our goal is to offer more Clubs & Sessions as they become available.\nMore information & registration",
              "image": null
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
            },
            {
              "id": 2578,
              "title": "Introducing our New CEO!",
              "date": "2021-06-07T23:32:52-04:00",
              "url": "https://raleighmasjid.org/introducing-our-new-ceo/",
              "text": "Assalamualaikum Community Members, My name is Danyal Khan and I am humbled and honored to be serving this community as the Islamic Association of Raleigh’s (IAR) CEO. My wife, Urosha…",
              "image": null
            },
            {
              "id": 2576,
              "title": "Jumuah Registration Update",
              "date": "2021-06-07T23:31:46-04:00",
              "url": "https://raleighmasjid.org/jumuah-registration-update/",
              "text": "In line with the Governor’s COVID-19 guidelines, registration is no longer required for jumuah, children above 5 years old will be allowed to come for all prayers, and spacing will…",
              "image": null
            },
            {
              "id": 2068,
              "title": "Introducing our new CEO: Br. Danyal",
              "date": "2021-05-05T19:08:11-04:00",
              "url": "https://raleighmasjid.org/introducing_our_new_ceo_br_dan/",
              "text": "Assalamualaikum Community Members,\nMy name is Danyal Khan and I am humbled and honored to be serving this community as the Islamic Association of Raleigh's (IAR) CEO. My wife, Urosha and I moved here from New Jersey in January of 2020 with our toddler son. We are excited to be a part of the Raleigh community and the IAR family.\nRead more.",
              "image": null
            },
            {
              "id": 2067,
              "title": "Donation Drive for Gambia",
              "date": "2021-05-05T00:13:57-04:00",
              "url": "https://raleighmasjid.org/donation_drive_for_gambia/",
              "text": "",
              "image": null
            },
            {
              "id": 2066,
              "title": "Al- Furqan School Registration 2021-2022",
              "date": "2021-04-28T19:32:28-04:00",
              "url": "https://raleighmasjid.org/al-_furqan_school_registration/",
              "text": "Registration for Al-Furqan School 2021-2022 is now open. Online registration can be completed via the website alfurqanschool.com.\nIn addition to the already discounted fees, there's a 10% early bird registration discount if registration and payment are completed by May 18th, 2021.\nPlease visit the website for more details.",
              "image": null
            },
            {
              "id": 2064,
              "title": "Guest Reciter Sh. Hasan Abunar on 4/24",
              "date": "2021-04-24T18:37:12-04:00",
              "url": "https://raleighmasjid.org/guest_reciter_sh_hasan_abunar/",
              "text": "Your masjid is honored to host the Imam of Taraweeh at Masjid Al-Aqsa in Jerusalem, Sh. Hasan Abunar, for both shifts of Taraweeh this upcoming Saturday, April 24! Registration is required.\n\nRegistration\nLivestream",
              "image": null
            },
            {
              "id": 2065,
              "title": "An-Noor Quran Academy Fundraiser",
              "date": "2021-04-24T01:18:05-04:00",
              "url": "https://raleighmasjid.org/an-noor_quran_academy_fundrais_1/",
              "text": "An-Noor Quran Academy (ANQA) cordially invites you and your family to the 12th Annual Virtual Fundraiser on May 1st, 2021 at 5:30 pm. Please visit our website for more details.",
              "image": null
            },
            {
              "id": 2063,
              "title": "IAR Deluxe Hajj Program 2021/1442",
              "date": "2021-04-18T21:50:39-04:00",
              "url": "https://raleighmasjid.org/iar_deluxe_hajj_program_202114/",
              "text": "Your Hajj Team is delighted to announce our IAR Hajj Program for 2021/1442.\nJoin our renowned IAR Hajj Family from this July 10th - July 26th for \"Truly, a life-changing experience!\"\nThe Hajj program, prices and the registration is now listed on the IAR Hajj Website.\nRead more",
              "image": null
            },
            {
              "id": 2058,
              "title": "Donations For Community Iftar at IAR – Ramadan 2021",
              "date": "2021-04-15T23:45:56-04:00",
              "url": "https://raleighmasjid.org/donations_for_community_iftar_3/",
              "text": "The Social & Welfare Committee will offer Iftar \"to go\" during this month of\nRamadan at IAR Monday through Thursday inshaAllah in a drive-thru fashion. Refugees, travelers, singles, and those in need can come and pick up their iftar-to-go\nbetween 6:00 pm and 7:00 pm. Read more\n\nClick here to donate",
              "image": null
            }
          ],
          "events": [
            {
              "id": 8372,
              "title": "High School Boys’ Night",
              "url": "https://raleighmasjid.org/program/brothers-high-school-halaqah-2021-01-09/2022-03-12/",
              "description": "High school brothers are invited to join their fellow youth for a weekly hangout featuring sports, video games, and an uplifting reminder followed by dinner. This program is an opportunity…",
              "start": "2022-03-12T19:00:00-05:00",
              "end": "2022-03-12T23:00:00-05:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 5427,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism/2022-03-13/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-13T00:00:00-05:00",
              "end": "2022-03-13T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 7782,
              "title": "YASEER – Youth Volunteerism",
              "url": "https://raleighmasjid.org/program/yaseer-youth-volunteerism-2021-01-10/2022-03-13/",
              "description": "Visit www.yaseer.live to learn all about this unique opportunity for youth to serve their community. Audience: High Schoolers Registration: www.yaseer.live/join Contact: admin@yaseer.live",
              "start": "2022-03-13T00:00:00-05:00",
              "end": "2022-03-13T23:59:59-04:00",
              "all_day": true,
              "repeating": true
            },
            {
              "id": 4882,
              "title": "Introduction to Islam",
              "url": "https://raleighmasjid.org/program/introduction-to-islam/2022-03-13/",
              "description": "Learn about Islam online from the comfort of your home! Due to COVID-19, we're now holding online classes instead of the in-person class. We invite you to participate live either…",
              "start": "2022-03-13T14:00:00-04:00",
              "end": "2022-03-13T15:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 10079,
              "title": "High School Girls’ Halaqa and Hangout",
              "url": "https://raleighmasjid.org/program/sisters-high-school-halaqah/2022-03-13/",
              "description": "Audience: High School Sisters Timing: Sundays from 2-4 PM Location: Sisters' Musallah (glass room) Click here for Registration & More Info.",
              "start": "2022-03-13T14:00:00-04:00",
              "end": "2022-03-13T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 9263,
              "title": "Ummi and Me: Storytime for Children",
              "url": "https://raleighmasjid.org/program/ummi-and-me-storytime-for-children/2022-03-16/",
              "description": "Join us for story time at Ummi and Me! The youngest members of our community (ages 0 - 5) are invited to attend with their caregivers. Activities include story time,…",
              "start": "2022-03-16T10:30:00-04:00",
              "end": "2022-03-16T12:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 4683,
              "title": "Elementary & Middle School Boys Saturday Program",
              "url": "https://raleighmasjid.org/program/elementary-middle-school-boys-saturday-program/2022-03-19/",
              "description": "Audience: Elementary & Middle School Boys Timing: Saturdays at 2 PM Registration & Contact: Mahen Khan - mahenmkhan@gmail.com",
              "start": "2022-03-19T14:00:00-04:00",
              "end": "2022-03-19T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 12121,
              "title": "Girls Saturday Program",
              "url": "https://raleighmasjid.org/program/girls-saturday-program/2022-03-19/",
              "description": "Visit the program page for up to date information and registration. Audience: Elementary, Middle, & High School Sisters Contact: Sr. Farrah Khan - farrah.khan@iaryouth.org",
              "start": "2022-03-19T14:00:00-04:00",
              "end": "2022-03-19T16:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
            {
              "id": 8373,
              "title": "High School Boys’ Night",
              "url": "https://raleighmasjid.org/program/brothers-high-school-halaqah-2021-01-09/2022-03-19/",
              "description": "High school brothers are invited to join their fellow youth for a weekly hangout featuring sports, video games, and an uplifting reminder followed by dinner. This program is an opportunity…",
              "start": "2022-03-19T19:00:00-04:00",
              "end": "2022-03-19T23:00:00-04:00",
              "all_day": false,
              "repeating": true
            },
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
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/Hanini.jpeg"
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
