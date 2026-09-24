-- 1of10 Ad Watchlist: shared edits and comments for scripts.html
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.script_edits (
  cell_key   text primary key,
  text       text not null,
  author     text,
  updated_at timestamptz not null default now()
);

create table if not exists public.script_comments (
  id         bigint generated always as identity primary key,
  cell_key   text not null,
  author     text,
  body       text not null,
  resolved   boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists script_comments_cell on public.script_comments (cell_key);

-- Anyone with the page link can read, write and resolve (same trust model as a Figma "anyone with the link can comment").
alter table public.script_edits    enable row level security;
alter table public.script_comments enable row level security;

drop policy if exists "edits read"   on public.script_edits;
drop policy if exists "edits write"  on public.script_edits;
drop policy if exists "edits update" on public.script_edits;
drop policy if exists "edits delete" on public.script_edits;
create policy "edits read"   on public.script_edits for select to anon using (true);
create policy "edits write"  on public.script_edits for insert to anon with check (true);
create policy "edits update" on public.script_edits for update to anon using (true) with check (true);
create policy "edits delete" on public.script_edits for delete to anon using (true);

drop policy if exists "comments read"   on public.script_comments;
drop policy if exists "comments write"  on public.script_comments;
drop policy if exists "comments update" on public.script_comments;
create policy "comments read"   on public.script_comments for select to anon using (true);
create policy "comments write"  on public.script_comments for insert to anon with check (true);
create policy "comments update" on public.script_comments for update to anon using (true) with check (true);

-- Optional guard rails
alter table public.script_comments add constraint body_len check (char_length(body) <= 4000);
alter table public.script_edits    add constraint text_len check (char_length(text) <= 8000);
