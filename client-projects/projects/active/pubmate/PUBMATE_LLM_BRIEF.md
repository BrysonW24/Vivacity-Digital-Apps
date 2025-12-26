# PubMate - Comprehensive LLM Brief

## Executive Summary

**PubMate** is a geo-located social pub discovery and event booking application designed to help users discover local pubs, connect with friends, attend curated events, and earn rewards through a gamified loyalty system. The app combines location-based discovery with social features and a venue partnership ecosystem.

---

## Core Problem Statement

Users struggle to:
1. **Discover new pubs** in their area beyond word-of-mouth recommendations
2. **Find friends** who are out at venues in real-time
3. **Discover events** happening at local pubs (live music, trivia, sports, etc.)
4. **Make bookings** for popular venues and events without phone calls
5. **Get rewarded** for visits and engagement with venues
6. **Share experiences** with friends through integrated social features

## Target Users

- **Primary**: Young professionals and social enthusiasts (21-40 years old)
- **Secondary**: Pub operators and venue managers
- **Tertiary**: Event organizers and DJs

---

## Core Features & Functionality

### 1. 🗺️ Venue Discovery (Geo-Location Based)
**Purpose**: Help users find nearby pubs and venues

#### Features:
- **Map View**
  - Interactive map showing venues as markers
  - User's current location (blue dot)
  - Search for specific venues by postcode/street name
  - Filter venues by distance (0.5-20km radius)
  - Cluster management for many venues in area

- **List View (Discover Screen)**
  - Real-time search by venue name or address
  - Category filtering (Pub, Bar, Club, etc.)
  - Distance-based sorting and filtering
  - Venue cards showing:
    - Image/thumbnail
    - Name and address
    - Distance away
    - Rating and review count
    - Key amenities (WiFi, outdoor seating, live music)
    - Foot traffic indicator (crowd level)
    - Open/closed status with hours

- **Venue Details Screen**
  - Full photo gallery
  - Complete amenities list
  - Opening hours and current status
  - Review section with user ratings and comments
  - Event calendar for that venue
  - Contact info (phone, website, map)
  - Share functionality
  - "Call" and "Navigate" buttons

#### Data Captured:
- Venue name, description, address
- Latitude/longitude coordinates
- Rating (1-5 stars) with review count
- Categories (Pub, Bar, Club, Restaurant, Cafe, etc.)
- **Amenities & Features** (see detailed section below)
- Phone number and website
- Price range indicator (£, ££, £££, ££££)
- Current open/closed status with hours
- Foot traffic indicator (approx people count)

#### 🎯 Venue Features & Amenities (Comprehensive List)

**This is critical for bar differentiation. Users filter and discover based on specific offerings.**

##### Entertainment & Games
- **Sports Facilities**
  - Sports Bar (multi-screen, live matches)
  - Pool Table (with pricing: £2/hour, £1/game)
  - Darts Board (with pricing: £1/game, League play)
  - Table Football/Foosball (pricing model)
  - Dart League Status (hosting league nights)
  - Trivia/Quiz Nights (schedule and frequency)
  - Karaoke (nights available, pricing)
  - Jukebox (free, subscription, or paid)
  - Gaming/Arcade Machines
  - Board Games Available
  - Ping Pong Table
  - Shuffleboard

##### Entertainment & Events
- Live Music (specific genres: rock, jazz, acoustic, cover bands)
- Live DJ (specific nights)
- Comedy Nights
- Open Mic Nights
- Movie Screenings
- Special Event Capacity
- Outdoor Event Space
- Private Event/Function Room (capacity and pricing)
- Happy Hour Details (times and specific deals)

##### Dining & Beverage
- Food Service (full menu, snacks, bar bites)
- Specific Cuisine Type (if applicable)
- Happy Hour (times and what's included)
- Cocktail Specialties
- Craft Beer Selection
- Wine Selection (by glass/bottle)
- Spirits Range
- Cider Selection
- Non-Alcoholic Options
- Food Delivery Options
- Sunday Roast (day/time)
- Burger Night (specific nights)

##### Atmosphere & Seating
- Outdoor Seating/Patio
- Garden/Terrace
- Rooftop Area
- Heated Outdoor Area
- Covered Smoking Area
- Family-Friendly
- Pet-Friendly (specific details: outside only, specific breeds)
- Quiet Area Available
- Large Groups Welcome
- Wheelchair Accessible
- Accessible Toilets
- Baby Changing Facilities

##### Technology & Connectivity
- Free WiFi (speed details optional)
- Charging Stations (USB, wireless)
- Live Sports Streaming (specific sports)
- Table Service/App Ordering
- Card/Cashless Only (or notes about payment)

##### Accessibility & Comfort
- Parking Available (type: street, lot, valet, free/paid)
- Public Transport Nearby
- Disabled Access
- Accessible Toilets
- Gender-Neutral Toilets
- High Chair Available
- Baby Changing
- Air Conditioning
- Heating System
- Music Volume Level (quiet, moderate, loud)

##### Safety & Experience
- Security (CCTV, door staff, security team)
- ID Policy (strict/relaxed/standard)
- Dress Code (smart casual, casual, formal)
- Age Restriction (18+, 21+, etc.)
- Late License (closing time, after-hours)
- First Aid Available
- Staff Training (safeguarding, etc.)

##### Special Offers & Programs
- Happy Hour Times & Deals
- Ladies Night (specific nights/details)
- Student Discount
- Loyalty Program (points, membership)
- Referral Rewards
- Group Booking Discounts
- Birthday Party Packages
- Private Event Options

##### Features by Bar Type (Suggested)

**Traditional Pub:**
- Quiz Nights ✓
- Darts ✓
- Real Ale Selection ✓
- Fireplace/Cozy Atmosphere ✓
- Board Games ✓
- Sunday Roast ✓
- Car Parking ✓

**Sports Bar:**
- Multi-Screen Sports ✓
- Pool Tables ✓
- Darts ✓
- Large Groups Welcome ✓
- Loud Music/Atmosphere ✓
- Late License ✓
- Standing Room ✓

**Cocktail Bar:**
- Craft Cocktails ✓
- Lounge Seating ✓
- DJ/Music ✓
- Smart Casual Dress Code ✓
- Premium Spirits ✓
- Happy Hour ✓
- Upscale Vibe ✓

**Casual Bar:**
- Happy Hour ✓
- Pool/Darts ✓
- Food Menu ✓
- Free WiFi ✓
- Varied Music ✓
- Mixed Age Groups ✓
- Family Areas ✓

**Club/Nightclub:**
- DJ/Dancing ✓
- Late License ✓
- Loud Music ✓
- Door Staff ✓
- VIP Areas ✓
- Premium Pricing ✓
- Age Restrictions ✓

##### Pricing Models for Activities

- **Pool Table**: £1-3 per game, £5-10 per hour
- **Darts**: £0.50-2 per game, league membership rates
- **Private Room**: £50-200+ per hour (min spend)
- **Karaoke**: Per song pricing or hourly room rental
- **Table Reservation**: Free-£50 depending on size/time
- **Happy Hour**: 30-60% discount on select items
- **Happy Hour Times**: Typically 4-7pm, 5-8pm

##### Data Model for Features

```
VenueFeature {
  id: String
  venueId: String
  featureName: String (e.g., "Pool Table", "Darts", "Sports Bar")
  category: String (entertainment, dining, seating, tech, events, etc.)
  isAvailable: boolean
  pricing: {
    hasPricing: boolean
    price: number
    priceUnit: String (per game, per hour, per item, etc.)
    currency: String
  }
  details: String (specific notes, e.g., "League play on Thursdays")
  scheduleAvailable: boolean
  schedule: {
    daysAvailable: Array<String> (Mon-Sun)
    timeStart: String (HH:MM format)
    timeEnd: String (HH:MM format)
  }
  capacity: number (if applicable, e.g., pool tables: 4 people)
  tags: Array<String> (searchable keywords)
}
```

##### Display & Filtering Strategy

**On Venue Card (Quick View):**
- Top 3-5 most distinctive features with icons
- Featured features pill badges: "🎱 Pool", "🎯 Darts", "📺 Sports", "🎤 Karaoke"
- Indicators: "Has Happy Hour", "Pet Friendly", "Free WiFi"

**On Venue Detail Screen (Full View):**
- Organized by category tabs
- Feature cards with:
  - Feature name and icon
  - Availability status
  - Pricing (if applicable)
  - Schedule (if applicable)
  - Detailed description
  - Photos/videos
  - User reviews specific to that feature

**In Search/Filter:**
- Multi-select filters by feature type
- "Sports Bars with Pool Tables"
- "Quiet Pubs with WiFi"
- "Venues with Outdoor Seating"
- "Happy Hour Now"
- "Pet-Friendly Bars"
- "Private Function Rooms"

**In Recommendations:**
- "If user looking for pool tables, show bars with pool tables in area"
- "If user books trivia event, show other bars with quiz nights"
- "Match user preferences to venue features"

---

---

### 2. 🎉 Event Discovery & Booking
**Purpose**: Allow users to discover and book events at venues

#### Features:
- **Event Browsing**
  - Upcoming events near user location (5-10km default)
  - Filter by event type (Live Music, Quiz Night, Sports, Trivia, Comedy, etc.)
  - Sort by date, distance, popularity
  - Tab interface: Upcoming Events vs. My Bookings

- **Event Details Screen**
  - Event title, description, and banner image
  - Date and time with calendar integration
  - Venue name (linked to venue details)
  - Category and tags (e.g., "Live Music", "Free Entry", "Food Available")
  - Attendee count and venue capacity
  - Price per person
  - Special features (hasFood, hasLiveMusic, etc.)
  - Attendee list (friend indicators)
  - One-click booking button
  - Capacity/sold-out status

- **Booking System**
  - Simple one-click booking confirmation
  - Booking confirmation notification
  - Ability to cancel bookings
  - "My Bookings" tab showing all booked events
  - Calendar view of booked events
  - Reminder notifications before event

#### Data Captured:
- Event ID, title, description
- Start and end times
- Venue ID and venue name
- Category (Live Music, Quiz, Sports, Trivia, Comedy, Karaoke, etc.)
- Tags (array of keywords)
- Attendee count and capacity
- Price per person
- Boolean flags: hasFood, hasLiveMusic
- Image/banner URL
- Booking status per user

---

### 3. 👥 Social Features - Friend Management
**Purpose**: Enable social discovery and connection

#### Features:
- **Friends List**
  - View all added friends
  - Friend status (online/offline indicator)
  - Last known venue (if they've shared location)
  - Friend requests section with accept/reject
  - Quick actions: message, view profile, remove friend
  - Search friends by name

- **Add Friends**
  - Search by email address
  - Send friend requests
  - Accept/decline incoming requests
  - Friend suggestion algorithm (based on activity)

- **Location Sharing** (Optional/Togglable)
  - Share current venue with friends (with permission)
  - See friends' last known locations
  - "Friends at this venue" indicator on venue cards
  - Real-time notifications when friends check in nearby

- **Social Activity Feed**
  - Friends' check-ins at venues
  - Friends' event bookings
  - Friends' reviews and ratings
  - Social sharing of achievements

#### Data Captured:
- Friend ID, name, email, avatar
- Friend status (active/inactive)
- Relationship status (pending/accepted/blocked)
- Last known location (lat/long) with venue name
- Location update timestamp
- Online/offline status

---

### 4. 🏆 Rewards & Loyalty System
**Purpose**: Gamify engagement and incentivize visits

#### Features:
- **Points Earning**
  - Visit/check-in at venues: +5-10 points
  - Attend events: +20-50 points
  - Leave a review: +10 points
  - Refer a friend: +25 points
  - Event attendance (shared): +10 bonus points
  - First visit to new venue: +15 points

- **Rewards Catalog**
  - Browse available rewards by venue
  - Reward cards showing:
    - Title and description
    - Points required
    - Venue name
    - Expiry date
    - Reward type (Free Drink, Discount, Food Item, etc.)
  - Points balance display (hero card)
  - Points history/transaction log

- **Redemption**
  - One-click redemption (if points sufficient)
  - Instant code generation or app-based redemption
  - Confirmation codes to show at venue
  - Redeemed rewards history
  - Points deduction upon redemption
  - Expiry warnings for expiring rewards

- **Gamification**
  - Leaderboard of top users (optional)
  - Badges for milestones (e.g., "50 Check-ins", "Friend Collector")
  - Special tier status (Bronze, Silver, Gold, Platinum)
  - Streak bonuses for consecutive visits

#### Data Captured:
- Reward ID, title, description, type
- Points required and points earned
- Venue association
- Expiry date
- Redemption status
- User's total points balance
- Points transaction history

---

### 5. 💬 Reviews & Ratings
**Purpose**: Build community feedback and trust

#### Features:
- **Review Posting**
  - Leave star rating (1-5 stars)
  - Write text review
  - Upload photos from visit
  - Review published with timestamp

- **Review Browsing**
  - See all reviews for a venue
  - Sort by: Most Recent, Most Helpful, Highest Rated
  - Filter by rating
  - User profiles with review history
  - Photos gallery from reviews

- **Review Management**
  - Edit own reviews
  - Delete own reviews
  - Helpful/unhelpful voting
  - Report inappropriate reviews

#### Data Captured:
- Review ID, venue ID, user ID
- Star rating (1-5)
- Review text
- Photos array (URLs)
- Creation date and edit history
- Helpful vote count

---

## User Journeys

### Journey 1: Discovery & Visit
1. User opens app → Location permission prompt
2. Browse "Discover" screen with nearby venues
3. Search for specific pub or filter by distance/category
4. Tap venue card → View details, reviews, ratings
5. Decide to visit → Share venue with friends
6. Visit venue → Check-in (earns 5-10 points)
7. Leave review and photos → Earn 10 points
8. See rewards available → Redeem points at next visit

### Journey 2: Social Hangout
1. User opens "Friends" tab
2. See online friends and their current venues
3. Tap friend → See their location
4. Navigate to venue → Friends are there
5. Check-in at venue → Earn points + friend bonus
6. See upcoming event → Book with friends
7. Get event reminder notification before event

### Journey 3: Event Attendance
1. User opens "Events" tab
2. Browse upcoming events near location
3. Filter by event type (Live Music, Sports, etc.)
4. Tap event → See details and attendees
5. Click "Book Event" → Instant confirmation
6. Share event with friends
7. Get reminder 1 hour before
8. Attend event → Earn points
9. Leave review → Earn bonus points

### Journey 4: Rewards Redemption
1. User opens "Rewards" screen
2. See points balance (e.g., 250 points)
3. Browse available rewards (Free Pint = 100 points)
4. Click "Redeem" → Confirm redemption
5. Get redemption code/QR code
6. Show to bartender at venue
7. Receive reward

---

## Technical Architecture

### Data Models
- **VenueModel**: Complete venue information with location data
- **EventModel**: Event details linked to venues with booking status
- **FriendModel**: User connections with location sharing
- **ReviewModel**: User-generated reviews with ratings
- **RewardModel**: Loyalty rewards with points system

### State Management
- **VenueProvider**: Manages venue discovery, search, filtering
- **EventProvider**: Manages event browsing and bookings
- **FriendProvider**: Manages social connections
- **RewardProvider**: Manages points and reward redemption

### Services
- **GeolocationService**: Location permission, tracking, distance calculation
- **ApiClient**: Backend API communication
- **NotificationService**: Push notifications for reminders/events
- **StorageService**: Local caching and offline capability

### UI Screens
- **DiscoverScreen**: Venue browsing and search
- **MapScreen**: Map view of venues and friends (TODO)
- **VenueDetailScreen**: Full venue information (TODO)
- **EventsScreen**: Event discovery and booking
- **EventDetailScreen**: Event details and booking (TODO)
- **FriendsScreen**: Social connections
- **RewardsScreen**: Loyalty and rewards
- **ReviewScreen**: Leave and view reviews (TODO)
- **ProfileScreen**: User profile and settings

### Backend Integration Points
- GET `/venues/nearby` - Fetch venues near location
- GET `/venues/{id}` - Fetch venue details
- GET `/venues/{id}/reviews` - Fetch venue reviews
- POST `/venues/{id}/reviews` - Create review
- GET `/events/nearby` - Fetch nearby events
- GET `/venues/{id}/events` - Fetch venue events
- POST `/events/{id}/book` - Book event
- DELETE `/bookings/{id}` - Cancel booking
- GET `/friends` - Fetch friends list
- POST `/friends/{id}/add` - Send friend request
- GET `/rewards` - Fetch available rewards
- GET `/user/points` - Fetch user points
- POST `/rewards/{id}/redeem` - Redeem reward

---

## Key Business Features

### For Users
1. **Discoverability** - Find new venues and events easily
2. **Social Integration** - Connect and hangout with friends
3. **Event Booking** - Simple, frictionless booking
4. **Gamified Rewards** - Earn points for engagement
5. **Community Reviews** - Trust-building through peer feedback

### For Venues
1. **Promotion** - Reach local users actively seeking venues
2. **Event Hosting** - Promote and manage events easily
3. **Booking System** - Integrated booking for capacity management
4. **Analytics** - Track foot traffic and user engagement
5. **Loyalty Integration** - Drive repeat visits through rewards
6. **Reviews & Ratings** - Build online reputation

### For Events/Entertainment
1. **Event Visibility** - Reach target audiences
2. **Attendance Tracking** - Know expected attendance
3. **Promotion** - Viral sharing through app
4. **Analytics** - Understand audience demographics

---

## Monetization Strategy

### Revenue Models
1. **Venue Subscription** - Venues pay monthly for listing management, analytics, event posting
2. **Featured Listings** - Venues pay to be featured in search results
3. **Premium Events** - Event organizers pay commission (5-10%) on bookings
4. **Sponsored Rewards** - Brands pay to feature rewards (not applicable initially)
5. **Commission on Bookings** - Take small percentage per confirmed booking
6. **Data Insights** - Anonymous venue insights sold to venue chains/brands

### Free Features for Users
- All discovery, browsing, and booking free
- Rewards based on organic activity
- Social features free

### Premium Features (Future)
- VIP event access
- Early booking privileges
- Exclusive rewards tier
- Ad-free experience

---

## Competitive Advantages

1. **Real-Time Social Layer** - See where friends are in real-time
2. **Integrated Booking** - One-tap event booking (vs. venues doing it separately)
3. **Gamified Loyalty** - Points system drives engagement
4. **Hyper-Local Focus** - Optimized for neighborhood-level discovery
5. **Community Reviews** - Authentic peer feedback
6. **Venue Analytics** - Venues get data they can't get elsewhere

---

## MVP Scope vs. Future Features

### MVP (Current - v1.0)
- ✅ Venue discovery and search
- ✅ Event browsing and booking
- ✅ Friend management
- ✅ Rewards system basics
- ✅ Reviews and ratings
- ✅ Geolocation services

### Phase 2 (v1.5)
- Push notifications for events/friends
- Map view refinement
- Offline capability
- Social sharing (WhatsApp, Instagram)
- Advanced filtering

### Phase 3 (v2.0)
- Venue dashboard (for venue operators)
- Advanced analytics
- Premium tier features
- Leaderboards and gamification badges
- In-app messaging between users
- Event livestream capability

### Phase 4 (v3.0+)
- AR features (AR menu at venue)
- AI recommendations
- Dynamic pricing for rewards
- Venue/event sponsorships
- Expansion to different venue types

---

## Success Metrics

### User Engagement
- Daily active users (DAU)
- Monthly active users (MAU)
- Average session duration
- Venue discovery to booking conversion rate
- Event booking rate
- Repeat user percentage

### Venue Success
- Number of venues listed
- Event bookings per venue
- Reward redemptions
- User review count

### Revenue
- Monthly recurring revenue (MRR)
- Customer acquisition cost (CAC)
- Lifetime value (LTV)
- Average revenue per user (ARPU)

### Community
- Total reviews posted
- Average venue rating
- Friends connections per user
- Social sharing rate

---

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| Cold start problem (no venues/events) | Partner with venues upfront before launch |
| User privacy concerns (location tracking) | Optional location sharing, clear privacy policy |
| Venue fraud (fake events/bookings) | Venue verification, user reviews, fraud detection |
| Low engagement after initial downloads | Gamification, push notifications, social features |
| Dependency on venue participation | Build venue benefits early, provide analytics value |
| Privacy regulations (GDPR, etc.) | Implement data minimization, user controls |
| Location accuracy issues | Use high-accuracy GPS, fallback to network location |

---

## Target Markets

### Initial Markets
1. **UK** - Major cities (London, Manchester, Birmingham, Edinburgh, Bristol)
2. **Australia** - Sydney, Melbourne, Brisbane
3. **US** - College towns and urban areas

### Market Sizing
- **TAM** (Total Addressable Market): 500M+ young professionals globally who visit pubs
- **SAM** (Serviceable Market): 50M in English-speaking countries
- **SOM** (Serviceable Obtainable): 5-10M in first 5 years

---

## Key Differentiators

1. **Friend Location Integration** - See where friends are without separate check-in app
2. **Integrated Event Booking** - No need for separate ticketing system
3. **Venue-First Loyalty** - Rewards specific to venues (not generic)
4. **Hyper-Local Focus** - Optimized for neighborhood discovery
5. **Community Driven** - Reviews and ratings build trust
6. **Simple UX** - Frictionless booking and rewards redemption

---

## Implementation Status

### ✅ Completed (Foundation)
- Project structure and boilerplate setup
- 5 data models (Venue, Event, Friend, Review, Reward)
- 4 state management providers
- 4 core UI screens (Discover, Events, Friends, Rewards)
- Geolocation service with permissions
- Configuration and strings
- Comprehensive documentation

### 🚧 In Progress
- API integration and repository layer
- Map screen implementation
- Detail screens (Venue/Event)

### ❌ Not Started
- Backend API development
- Venue partner integration
- Push notifications
- Testing suite
- Analytics implementation
- Production deployment

---

## Conclusion

**PubMate** is a comprehensive solution for social pub discovery, event booking, and venue engagement. By combining location-based discovery with social features and a gamified loyalty system, it creates a win-win ecosystem for users, venues, and event organizers.

The app solves real problems in the pub/bar space:
- **For users**: Easy discovery and social hangouts
- **For venues**: Foot traffic, bookings, and customer engagement
- **For events**: Audience reach and attendance tracking
- **For everyone**: Fun, gamified experience with rewards

The MVP is technically solid and ready for API integration and testing. With venue partnerships and smart marketing, PubMate has significant potential in the social entertainment space.

---

**Version**: 1.0
**Date**: December 2025
**Status**: MVP Phase - Ready for Development
