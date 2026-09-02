# Teacher role — Supabase integration plan

Goal
- Provide a single, complete plan and checklist to connect the Teacher role UI to Supabase. This includes project setup, DB schema, storage, RLS/security, Flutter integration, error handling, realtime subscriptions, migration SQL, and a prioritized implementation plan tied to the files in the codebase.

Checklist (work items)
- [ ] Create Supabase project (staging + prod) and obtain URL & ANON key
- [ ] Create storage buckets: avatars, lesson-videos, lesson-pdfs, attachments
- [ ] Create DB schema (tables + indexes) and run migrations
- [ ] Enable Row Level Security (RLS) and add policies for each table
- [ ] Add supabase_flutter dependency and initialize Supabase in app
- [ ] Implement data layer (client wrapper, repositories, storage service)
- [ ] Wire UI screens to repositories (Subjects & Classes, Teacher Profile, Edit Profile, Lessons, Chats)
- [ ] Implement realtime subscriptions for chats/notifications/lesson updates
- [ ] Add robust error mapping and retry/rollback logic for uploads
- [ ] Add tests and local development flow (supabase CLI / migrations)

Priority quick wins
1. Wire `Subjects & Classes` screen (there is a TODO in `subjects_classes_screen.dart`) to Supabase CRUD. This gives immediate visible results.
2. Implement `TeacherProfile` read & `TeacherEditProfile` save + avatar upload.
3. Implement `Lessons` create flow (video/pdf upload + DB insert) using the sample `teacher_lessons_supabase_data_source.dart` as model.
4. Add basic chats list and realtime subscription.

High-level architecture
- App startup: initialize Supabase once in `main.dart` / `edura_app.dart` with env values.
- Data layer (lib/data or lib/core/services): one wrapper for supabase client + repositories per domain (teachers, subjects, lessons, chats, students).
- Domain layer: use cases that call repositories (already present for lessons in `domain/use_case`).
- Presentation layer: view models (ChangeNotifier or Riverpod providers) call use cases and expose state to widgets.
- Error mapping: map Supabase exceptions to app-friendly `AppError` types (NoInternetError, TimeoutError, ServerError, UnknownServerError).

Full inventory & per-tab logic (complete)
Below is a compact but complete inventory of the Teacher role UI files and the logical features implemented in each tab. Use this as a checklist to wire each screen to Supabase.

Top-level / main layout
- `lib/presentation/role/teacher/teacher_main_layout.dart` — Main teacher bottom-navigation and PageView that hosts the five tabs (Dashboard, Lessons, Students, Chats, Profile).

Dashboard (analytics & quick actions)
- `lib/presentation/role/teacher/tabs/dashboard/dashboard.dart` — Dashboard screen with stats, quick-action buttons (add lesson, take attendance, create exam), recent activity list.
- `lib/presentation/role/teacher/tabs/dashboard/section/*` — analytics screen, notifications, attendance screens and widgets used by dashboard.

Lessons (already has working data flow example)
- `lib/presentation/role/teacher/tabs/teacher_lessons/presentation/view/teacher_lessons.dart` — Lessons main screen (Published / Drafts tabs, add/edit flow).
- `lib/presentation/role/teacher/tabs/teacher_lessons/presentation/view/section/*` — Add/Edit lesson screens, lesson details form, homework review screens.
- `lib/presentation/role/teacher/tabs/teacher_lessons/presentation/view/widgets/*` — Lesson form widgets (video/pdf upload, file dropzone, lesson card, etc.).
- `lib/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/teacher_lessons_view_model.dart` — Cubit/ViewModel for create/update/delete flows.
- `lib/presentation/role/teacher/tabs/teacher_lessons/data/*` — Remote data source (`teacher_lessons_supabase_data_source.dart`), repository implementation and model (`NewLessonModel`). This file contains robust upload, rollback and error mapping — use it as a template for other upload flows.

Students
- `lib/presentation/role/teacher/tabs/students/students.dart` — Students list + search. Currently uses dummy models; should query `students` via repository.
- `lib/presentation/role/teacher/tabs/students/section/*` — Student details screen and widgets (progress, exam results, attendance history, contact info).

Chats
- `lib/presentation/role/teacher/tabs/teacher_chats/teacher_chats.dart` — Conversations list UI (currently dummy data). Replace with `chats`/`messages` queries and subscribe to realtime messages.
- `lib/presentation/role/teacher/tabs/teacher_chats/section/chat_conversation_card.dart` — Conversation list item widget.

Profile & Settings
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_profile.dart` — Teacher profile screen (hardcoded model currently). Load data from `teachers` table.
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_edit_profile/*` — Edit profile UI: form fields and avatar picker. On save: upload avatar and call updateTeacherProfile.
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_setting/*` — Settings screen and sections: account, preferences, notifications, support, subjects & classes CRUD (subjects_classes_screen.dart contains TODO to replace hardcoded list).

Other widgets & helpers
- Many small widgets exist under each tab (stat cards, charts, form components). They should consume data from the view-models/cubits once repositories are wired.

Use this inventory to mark files as "wired to Supabase" during implementation. Prioritize screens with TODOs and those that show hardcoded data.

Supabase project setup (console)
1. Create project on Supabase: name, region.
2. In Settings → API, copy the Project URL and ANON public key (for client). Store securely in env.
3. Create buckets in Storage:
   - avatars (public read or signed urls depending on privacy)
   - lesson-videos
   - lesson-pdfs
   - attachments
4. Set CORS (if you use web) and enable Postgres extensions if needed.
5. Create service_role key for server-side trusted operations (DO NOT embed in mobile app).

Local dev / CLI
- Install supabase CLI (if you want local DB and migrations).
PowerShell example commands:
```powershell
# install supabase CLI (if not installed, follow supabase docs)
# login
supabase login
# start local stack
supabase start
# initialize migrations directory (once)
supabase migration new init_schema
# apply migrations
supabase db push
```

Environment variables (store safely)
- SUPABASE_URL
- SUPABASE_ANON_KEY
- SUPABASE_SERVICE_ROLE_KEY (only on secure server, never in app)
- Optionally: SUPABASE_STORAGE_URL if custom

Database schema (starter migrations)
-- Teachers, Subjects, Lessons, Chats, Messages, ClassStudents
-- Example migration SQL (adapt to your naming)

```sql
-- 01_create_teachers.sql
create table teachers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  full_name text,
  email text,
  avatar_url text,
  subject text,
  years_experience int,
  settings jsonb default '{}'::jsonb,
  created_at timestamptz default now()
);

create index on teachers (user_id);

-- 02_create_subjects.sql
create table subjects (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid references teachers(id) on delete cascade,
  name text not null,
  created_at timestamptz default now()
);
create index on subjects (teacher_id);

-- 03_create_lessons.sql
create table lessons (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid references teachers(id) on delete cascade,
  subject text,
  title text not null,
  overview_description text,
  duration_minutes int,
  video_url text,
  pdf_url text,
  is_published boolean default false,
  is_premium boolean default false,
  is_completed boolean default false,
  view_count int default 0,
  rating numeric default 0,
  progress int default 0,
  materials jsonb default '[]'::jsonb,
  created_at timestamptz default now()
);
create index on lessons (teacher_id);

-- 04_create_chats_messages.sql
create table chats (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid references teachers(id),
  student_id uuid, -- or nullable for group chats
  last_message_at timestamptz,
  metadata jsonb default '{}'::jsonb
);

create table messages (
  id uuid primary key default gen_random_uuid(),
  chat_id uuid references chats(id) on delete cascade,
  sender_id uuid,
  text text,
  attachments jsonb default '[]'::jsonb,
  created_at timestamptz default now()
);
create index on messages (chat_id, created_at desc);

-- 05_class_students/registrations (optional)
create table class_students (
  id uuid primary key default gen_random_uuid(),
  class_id uuid,
  student_id uuid,
  enrolled_at timestamptz default now()
);
```

RLS and Policies (examples)
- Enable RLS on tables and add policies that use `auth.uid()` (JWT sub) to ensure teachers see only their rows.

Example for `teachers` table:
```sql
alter table teachers enable row level security;

create policy "Allow teacher to select their row" on teachers
  for select using (user_id = auth.uid());

create policy "Allow teacher insert their row" on teachers
  for insert with check (user_id = auth.uid());

create policy "Allow teacher update their row" on teachers
  for update using (user_id = auth.uid()) with check (user_id = auth.uid());
```

Example for `subjects`:
```sql
alter table subjects enable row level security;
create policy "subjects_access_for_teacher" on subjects
  for all using (teacher_id = (select id from teachers where user_id = auth.uid()))
  with check (teacher_id = (select id from teachers where user_id = auth.uid()));
```

Example for `lessons`:
```sql
alter table lessons enable row level security;
create policy "lessons_read_published_or_owner" on lessons
  for select using (
    is_published = true
    or teacher_id = (select id from teachers where user_id = auth.uid())
  );

create policy "lessons_write_for_owner" on lessons
  for insert, update, delete using (teacher_id = (select id from teachers where user_id = auth.uid()))
  with check (teacher_id = (select id from teachers where user_id = auth.uid()));
```

Security notes
- Never embed the service_role key in mobile apps. Use anon key + RLS. If a server needs elevated access, keep service_role on the server.
- For files you want private: use signed URLs. For public, getPublicUrl is fine.

Storage & upload strategy
- Buckets: avatars (avatars/teacherId/<filename>), lesson-videos (videos/<teacherId>/<timestamp>_<name>), lesson-pdfs (pdfs/<teacherId>/...), attachments (attachments/<chatId>/...)
- Use `supabase.storage.from(bucket).upload(path, File, fileOptions: FileOptions(upsert: true))` as in `teacher_lessons_supabase_data_source.dart`.
- For large videos:
  - Consider server-side transcoding or storing original and serving compressed versions.
  - Supabase Storage currently uploads from client; monitor max file size. If you expect very large files, consider direct S3 with multipart or a server-side signed URL endpoint.
- Rollback: if a DB insert fails after file upload, delete uploaded file(s) — the example in `teacher_lessons_supabase_data_source.dart` already does this.

Flutter integration (practical)
1. Pubspec
```yaml
dependencies:
  supabase_flutter: ^1.0.0 # use latest stable
  flutter_dotenv: ^5.0.2 # for env variables
  # other libs (provider/riverpod) as used by app
```

2. Initialize (in `main.dart` or `edura_app.dart`)
```dart
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );
  runApp(const EduraApp());
}
```
(Or use `flutter_dotenv` to load keys from .env during dev.)

3. Auth flow
- On user sign up: create a `teachers` row linking `user_id` to `auth.uid()` if not exists. This can be done client-side after sign-in or via a Postgres function triggered on insert into auth.users.
- Keep `full_name` in `user_metadata` as well (Supabase `auth` supports updating metadata).

4. Data layer examples (pseudo)
- supabase_client.dart: expose `final supabase = Supabase.instance.client;`
- teacher_repository.dart: provide `Future<TeacherProfile> getTeacherProfile()` which queries `teachers` where `user_id = auth.uid()`.

5. Mapping UI to files to change (priority order)
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/subjects_classes_screen.dart` — replace the TODO/hardcoded list with a repository call and display.
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_profile.dart` — load teacher data from repository instead of hardcoded model.
- `lib/presentation/role/teacher/tabs/teacher_profile/teacher_edit_profile/teacher_edit_profile_screen.dart` — upload avatar (if any), call repository.updateTeacherProfile and handle errors.
- Lessons flow: `lib/presentation/role/teacher/tabs/teacher_lessons/data/data_source/teacher_lessons_supabase_data_source.dart` — already a good example. Wire it into `teacher_lessons_repositories_imp.dart` -> `teacher_lessons_use_case.dart` -> `teacher_lessons_view_model.dart` -> `presentation/view/*`.

Detailed createLesson flow (best practices)
1. Validate inputs locally (title, subject, files, duration) and show UI error messages early.
2. Upload files (video, pdf) to their buckets before inserting the DB row.
   - Use unique storage paths: `$folder/$teacherId/${timestamp}_<basename>`.
   - Track uploaded paths so you can rollback on error.
3. Insert DB row referencing uploaded URLs or storage paths.
   - Prefer saving storage path (not only public URL) so you can generate signed URLs later if needed.
4. If DB insert fails, remove uploaded files (rollback). If file upload fails, stop and show error.
5. Map Supabase exceptions to `AppError` types and show appropriate messages in UI.
6. Consider optimistic UI updates (e.g., add placeholder lesson to list while upload & insert complete).

Edge cases & reliability
- Network Loss: make uploads cancellable and retryable. Use background isolates if UI must not block.
- Timeouts: set sensible timeouts and show a retry button.
- Partial failures: always delete uploaded files if insert fails.
- Storage quota & limits: monitor and set lifecycle rules if needed.

Realtime & notifications
- Use Supabase Realtime (or `from('messages').on('INSERT')`) to push messages to teachers in chat.
- For app push notifications (APNs/FCM): use server functions to trigger notifications when important DB events happen (new message, announcement, etc.).

Testing & staging
- Have a staging Supabase project and reuse same schema.
- Use migrations via supabase CLI for reproducibility.
- Write unit tests around repositories using mocked Supabase client or a local Postgres instance.

Monitoring & cost
- Monitor storage, bandwidth (videos can be expensive). Consider transcoding and lower bitrate storage.
- Limit file sizes client-side (e.g., 200MB max) and show a clear error.

Deliverable: concrete tasks to implement now (step-by-step)
1. Add `supabase_flutter` and `flutter_dotenv` to `pubspec.yaml` and run `flutter pub get`.
2. Initialize Supabase in `main.dart` / `edura_app.dart` with env vars.
3. Create `lib/data/supabase/supabase_client.dart` (simple wrapper) and `lib/data/supabase/teacher_repository.dart` with:
   - getOrCreateTeacherForCurrentUser()
   - getTeacherProfile()
   - updateTeacherProfile(Map<String, dynamic> data, File? avatarFile)
4. Implement `lib/data/supabase/storage_service.dart` with `uploadAvatar`, `uploadLessonVideo`, `uploadLessonPdf`, `getPublicUrl`, `remove(path)`.
5. Wire `subjects_classes_screen.dart` to call `subjectRepository.listSubjects()` and implement create/update/delete actions.
6. Hook `teacher_edit_profile_screen.dart` to call `teacherRepository.updateTeacherProfile(...)` and to call `storageService.uploadAvatar(...)`.
7. Reuse `teacher_lessons_supabase_data_source.dart` for lessons creation; ensure repository/use case/view model are connected to the presentation UI.
8. Add migrations and RLS policies and push to staging.
9. Manually test: sign-up as teacher → create teacher row → edit profile (upload avatar) → create a subject → create a lesson with video/pdf → verify files exist and lesson row created.

Useful code snippets
- Generate a unique storage path (Dart):
```dart
final teacherId = (await supabase.auth.getUser()).user?.id ?? 'unknown';
final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
final storagePath = 'videos/$teacherId/$fileName';
```

- Upload with rollback pattern (pseudo):
```dart
authorize user (auth.uid())
try {
  final videoPath = await storage.upload(...);
  final pdfPath = await storage.upload(...);
  final row = await supabase.from('lessons').insert({...}).select().single();
} catch (e) {
  // delete uploaded files if needed
  if (videoPath != null) await storage.remove(videoPath);
  if (pdfPath != null) await storage.remove(pdfPath);
  rethrowMappedError(e);
}
```

Mapping to workspace files (actionable edits)
- Update these files to call repositories / services instead of the current local/hardcoded data:
  - `lib/presentation/role/teacher/tabs/teacher_profile/teacher_setting/section/subjects_classes_screen.dart` (TODO present)
  - `lib/presentation/role/teacher/tabs/teacher_profile/teacher_profile.dart`
  - `lib/presentation/role/teacher/tabs/teacher_profile/teacher_edit_profile/teacher_edit_profile_screen.dart`
  - `lib/presentation/role/teacher/tabs/teacher_lessons/*` (presentation/view and view_model to wire to repository)
  - `lib/presentation/role/teacher/tabs/teacher_chats/*` (subscribe to messages table)

Appendix: Example errors mapping (recommended)
- SocketException -> NoInternetError
- TimeoutException -> TimeoutError
- PostgrestException -> ServerError
- StorageException -> ServerError
- Any other -> UnknownServerError

Final notes and guidance
- Start with Subjects & Profile to get fast wins.
- Follow the pattern used in `teacher_lessons_supabase_data_source.dart` for uploads and error handling — it already contains rollback logic, error mapping, and sensible storage path naming.
- Keep service_role key off the client. Use serverless functions or backend-only services for expensive ops (e.g., transcoding, moderation, report generation).

If you want, I can:
- Create skeleton repository files (`supabase_client.dart`, `teacher_repository.dart`, `storage_service.dart`) and wire one UI screen (Subjects) to Supabase in code.
- Generate SQL migration files for the schema and policies and add them to a `supabase/migrations` folder.

-- End of plan

