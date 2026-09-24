-- 1of10 Ad Watchlist: shared edits and comments for scripts.html (v2: owner-only editing)
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Before running, replace OWNER_SECRET_HERE with a passphrase only the owner knows.

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
alter table public.script_comments add column if not exists status text not null default 'open';
alter table public.script_comments add column if not exists parent_id bigint references public.script_comments(id) on delete cascade;
alter table public.script_comments add column if not exists status_by text;
alter table public.script_comments add column if not exists status_at timestamptz;
create index if not exists script_comments_cell on public.script_comments (cell_key);

-- Private settings: no anon policies, so nobody can read it through the API.
create table if not exists public.script_settings (
  key   text primary key,
  value text not null
);
alter table public.script_settings enable row level security;
insert into public.script_settings (key, value) values ('owner_secret', 'OWNER_SECRET_HERE')
  on conflict (key) do update set value = excluded.value;

alter table public.script_edits    enable row level security;
alter table public.script_comments enable row level security;

-- Everyone with the link: read edits, read and post comments and replies. Nothing else directly.
drop policy if exists "edits read"      on public.script_edits;
drop policy if exists "edits write"     on public.script_edits;
drop policy if exists "edits update"    on public.script_edits;
drop policy if exists "edits delete"    on public.script_edits;
create policy "edits read" on public.script_edits for select to anon using (true);

drop policy if exists "comments read"   on public.script_comments;
drop policy if exists "comments write"  on public.script_comments;
drop policy if exists "comments update" on public.script_comments;
create policy "comments read"  on public.script_comments for select to anon using (true);
create policy "comments write" on public.script_comments for insert to anon
  with check (status = 'open' and status_by is null and status_at is null);

-- Owner-only actions go through these functions, which check the passphrase.
create or replace function public.check_owner(p_secret text)
returns boolean language sql security definer set search_path = public as $$
  select exists (select 1 from public.script_settings where key = 'owner_secret' and value = p_secret);
$$;

create or replace function public.save_edit(p_key text, p_text text, p_author text, p_secret text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.check_owner(p_secret) then raise exception 'not owner' using errcode = '42501'; end if;
  if p_text is null or p_text = '' then
    delete from public.script_edits where cell_key = p_key;
  else
    insert into public.script_edits (cell_key, text, author, updated_at) values (p_key, p_text, p_author, now())
      on conflict (cell_key) do update set text = excluded.text, author = excluded.author, updated_at = now();
  end if;
end $$;

create or replace function public.set_comment_status(p_id bigint, p_status text, p_by text, p_secret text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.check_owner(p_secret) then raise exception 'not owner' using errcode = '42501'; end if;
  if p_status not in ('open','approved','done') then raise exception 'bad status'; end if;
  update public.script_comments set status = p_status, resolved = (p_status = 'done'),
    status_by = case when p_status = 'open' then null else p_by end,
    status_at = case when p_status = 'open' then null else now() end
  where id = p_id;
end $$;

grant execute on function public.check_owner(text) to anon;
grant execute on function public.save_edit(text, text, text, text) to anon;
grant execute on function public.set_comment_status(bigint, text, text, text) to anon;

-- Guard rails
do $$ begin
  alter table public.script_comments add constraint body_len check (char_length(body) <= 4000);
exception when duplicate_object then null; end $$;
do $$ begin
  alter table public.script_edits add constraint text_len check (char_length(text) <= 8000);
exception when duplicate_object then null; end $$;
