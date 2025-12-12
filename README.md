# Focus & Habit Coach for Students

AI-powered study habit coaching app for students. Built with Flutter, Supabase, and OpenAI.

## Features

✅ **Onboarding** - Student profile setup (name, study level, subjects, session preferences)
✅ **Today Dashboard** - Daily tasks, streak counter, focus statistics
✅ **Plan Today** - Task editor with subject selection and session management
✅ **Focus Session Timer** - Full-screen Pomodoro timer (15-60 minutes customizable)
✅ **Progress Analytics** - Weekly charts, streak tracking, total focus minutes
✅ **AI Coach** - AI-powered study plan generator powered by OpenAI
✅ **Responsive Design** - Mobile and web optimized (single codebase)
✅ **Real-time Sync** - Data synced across devices via Supabase

## Tech Stack

- **Frontend**: Flutter (cross-platform)
- **Backend**: Supabase (Postgres + Real-time APIs)
- **AI**: OpenAI GPT integration
- **Authentication**: Supabase Auth
- **Database**: 5 normalized tables with foreign keys

## Database Tables

1. **users** - Student profiles
2. **subjects** - Color-coded subjects per student
3. **daily_plans** - Task management
4. **focus_sessions** - Session tracking with time logs
5. **habit_stats** - Streaks, total minutes, analytics

## Setup Instructions

### Prerequisites
- Flutter SDK
- Supabase account
- OpenAI API key

### Installation

```bash
# Clone the repository
git clone https://github.com/sricharan-yadav/focus-habit-coach.git
cd focus-habit-coach

# Install dependencies
flutter pub get

# Update configuration
# Replace YOUR_ANON_KEY_HERE in lib/main.dart with your Supabase ANON_KEY

# Run the app
flutter run
```

## Deployment

```bash
# Build for web
flutter build web

# Deploy to Firebase Hosting
firebase deploy --only hosting

# Deploy to mobile stores
# Follow Flutter documentation for iOS and Android
```

## Project Status

✅ MVP Complete
✅ All 6 screens built
✅ Supabase backend ready
✅ AI integration configured
✅ Ready for Dreamflow Buildathon submission

## License

MIT License - feel free to use and modify

## Author

sricharan-yadav

## Support

For issues or questions, open an issue on GitHub.
