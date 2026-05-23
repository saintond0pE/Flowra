-- 1. Create leads table (if not exists)
create table if not exists public.leads (
  id text primary key,
  name text not null,
  email text,
  number text,
  message text,
  status text default 'new',
  lead_lock text,
  created_at timestamptz default now()
);

-- Enable Row Level Security (RLS) on leads
alter table public.leads enable row level security;

-- Enable public read/write/upsert access on leads
drop policy if exists public_all_leads on public.leads;
create policy public_all_leads on public.leads for all using (true) with check (true);

-- 2. Create clients table (if not exists)
create table if not exists public.clients (
  id text primary key, -- Same as lead_id for 1-to-1 matching
  lead_id text references public.leads(id) on delete cascade,
  name text not null,
  email text,
  number text,
  status text default 'working',
  created_at timestamptz default now(),
  converted_at timestamptz default now()
);

-- Enable Row Level Security (RLS) on clients
alter table public.clients enable row level security;

-- Enable public read/write/upsert access on clients
drop policy if exists public_all_clients on public.clients;
create policy public_all_clients on public.clients for all using (true) with check (true);

-- 3. Create helper views for easy division on Supabase dashboard
-- View for prospects & leads (status new or contacted)
create or replace view public.leads_prospects as
select *
from public.leads
where status in ('new', 'contacted');

-- View for converted clients (status working, finished, or closed)
create or replace view public.leads_clients as
select *
from public.leads
where status in ('working', 'finished', 'closed');

-- 4. Performance Indexes
create index if not exists idx_leads_status on public.leads (status);
create index if not exists idx_clients_status on public.clients (status);
