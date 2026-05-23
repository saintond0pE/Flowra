-- Schema for the clients table to differentiate converted leads/clients from prospects
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

-- Enable Row Level Security (RLS)
alter table public.clients enable row level security;

-- Drop policy if it already exists
drop policy if exists public_all_clients on public.clients;

-- Enable public read/write/upsert access (aligns with the leads and invoice_lock tables)
create policy public_all_clients
on public.clients
for all
using (true)
with check (true);
