-- Create profiles table
create table profiles (
    id uuid references auth.users on delete cascade not null primary key,
    full_name text not null,
    email text not null,
    role text not null check (role in ('professor', 'student')),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create classes table
create table classes (
    id uuid default gen_random_uuid() primary key,
    name text not null,
    professor_id uuid references profiles(id) not null,
    active boolean default true not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create class_enrollments table
create table class_enrollments (
    class_id uuid references classes(id) on delete cascade not null,
    student_id uuid references profiles(id) on delete cascade not null,
    enrolled_at timestamp with time zone default timezone('utc'::text, now()) not null,
    primary key (class_id, student_id)
);

-- Create attendance_sessions table
create table attendance_sessions (
    id uuid default gen_random_uuid() primary key,
    class_id uuid references classes(id) on delete cascade not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    expires_at timestamp with time zone not null,
    session_code text not null
);

-- Create attendance_records table
create table attendance_records (
    session_id uuid references attendance_sessions(id) on delete cascade not null,
    student_id uuid references profiles(id) on delete cascade not null,
    marked_at timestamp with time zone default timezone('utc'::text, now()) not null,
    primary key (session_id, student_id)
);

-- Set up Row Level Security (RLS)
alter table profiles enable row level security;
alter table classes enable row level security;
alter table class_enrollments enable row level security;
alter table attendance_sessions enable row level security;
alter table attendance_records enable row level security;

-- Profiles policies
create policy "Public profiles are viewable by everyone"
on profiles for select
using (true);

create policy "Users can update their own profile"
on profiles for update
using (auth.uid() = id);

-- Classes policies
create policy "Classes are viewable by everyone"
on classes for select
using (true);

create policy "Professors can create classes"
on classes for insert
with check (auth.uid() = professor_id);

create policy "Professors can update their own classes"
on classes for update
using (auth.uid() = professor_id);

-- Class enrollments policies
create policy "Enrollments are viewable by everyone"
on class_enrollments for select
using (true);

create policy "Students can enroll themselves"
on class_enrollments for insert
with check (auth.uid() = student_id);

-- Attendance sessions policies
create policy "Sessions are viewable by everyone"
on attendance_sessions for select
using (true);

create policy "Professors can create sessions for their classes"
on attendance_sessions for insert
with check (exists (
    select 1 from classes
    where id = class_id
    and professor_id = auth.uid()
));

-- Attendance records policies
create policy "Records are viewable by everyone"
on attendance_records for select
using (true);

create policy "Students can mark their own attendance"
on attendance_records for insert
with check (
    auth.uid() = student_id
    and exists (
        select 1 from attendance_sessions
        where id = session_id
        and expires_at > now()
    )
);

-- Create functions for updating timestamps
create or replace function update_updated_at_column()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

-- Create triggers for updating timestamps
create trigger update_profiles_updated_at
    before update on profiles
    for each row
    execute procedure update_updated_at_column();

create trigger update_classes_updated_at
    before update on classes
    for each row
    execute procedure update_updated_at_column();
