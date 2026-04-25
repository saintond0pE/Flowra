-- Full invoice_lock schema for dashboard + n8n direct sync
-- Run this in Supabase SQL editor.

create table if not exists public.invoice_lock (
  lead_id text not null,
  project_id text not null,
  invoice_id text,
  lead_name text,
  lead_email text,
  project_name text,
  project_ids jsonb default '[]'::jsonb,
  project_names jsonb default '[]'::jsonb,
  modules text[] default '{}',
  payment_mode text,
  payment_method text default 'upi',
  base_amount numeric default 0,
  addon_amount numeric default 0,
  previous_locked_total numeric default 0,
  current_charge_base numeric default 0,
  locked_total numeric default 0,
  upfront_percent numeric default 25,
  upfront_amount numeric default 0,
  partial_percent_of_upfront numeric default 0,
  due_now_amount numeric default 0,
  paid_now_amount numeric default 0,
  remaining_amount numeric default 0,
  currency text default 'INR',
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint invoice_lock_pkey primary key (lead_id, project_id)
);

alter table public.invoice_lock add column if not exists invoice_id text;
alter table public.invoice_lock add column if not exists lead_name text;
alter table public.invoice_lock add column if not exists lead_email text;
alter table public.invoice_lock add column if not exists project_name text;
alter table public.invoice_lock add column if not exists project_ids jsonb default '[]'::jsonb;
alter table public.invoice_lock add column if not exists project_names jsonb default '[]'::jsonb;
alter table public.invoice_lock add column if not exists modules text[] default '{}';
alter table public.invoice_lock add column if not exists payment_mode text;
alter table public.invoice_lock add column if not exists payment_method text default 'upi';
alter table public.invoice_lock add column if not exists base_amount numeric default 0;
alter table public.invoice_lock add column if not exists addon_amount numeric default 0;
alter table public.invoice_lock add column if not exists previous_locked_total numeric default 0;
alter table public.invoice_lock add column if not exists current_charge_base numeric default 0;
alter table public.invoice_lock add column if not exists locked_total numeric default 0;
alter table public.invoice_lock add column if not exists upfront_percent numeric default 25;
alter table public.invoice_lock add column if not exists upfront_amount numeric default 0;
alter table public.invoice_lock add column if not exists partial_percent_of_upfront numeric default 0;
alter table public.invoice_lock add column if not exists due_now_amount numeric default 0;
alter table public.invoice_lock add column if not exists paid_now_amount numeric default 0;
alter table public.invoice_lock add column if not exists remaining_amount numeric default 0;
alter table public.invoice_lock add column if not exists currency text default 'INR';
alter table public.invoice_lock add column if not exists notes text;
alter table public.invoice_lock add column if not exists created_at timestamptz default now();
alter table public.invoice_lock add column if not exists updated_at timestamptz default now();

-- Ensure one row per lead/project for conflict upserts.
do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'invoice_lock_pkey'
  ) then
    alter table public.invoice_lock
      add constraint invoice_lock_pkey primary key (lead_id, project_id);
  end if;
end $$;

create index if not exists idx_invoice_lock_updated_at_desc on public.invoice_lock(updated_at desc);
create index if not exists idx_invoice_lock_invoice_id on public.invoice_lock(invoice_id);

alter table public.invoice_lock enable row level security;
drop policy if exists public_all_invoice_lock on public.invoice_lock;
create policy public_all_invoice_lock
on public.invoice_lock
for all
using (true)
with check (true);

-- n8n can fetch this view directly to get normalized payload.
create or replace view public.v_invoice_lock_payload as
select
  il.lead_id,
  il.project_id,
  il.invoice_id,
  il.lead_name,
  coalesce(il.lead_email, l.email, '') as lead_email,
  il.project_name,
  il.project_ids,
  il.project_names,
  il.modules,
  il.payment_mode,
  il.payment_method,
  il.base_amount,
  il.addon_amount,
  il.previous_locked_total,
  il.current_charge_base,
  il.locked_total,
  il.upfront_percent,
  il.upfront_amount,
  il.partial_percent_of_upfront,
  il.due_now_amount,
  il.paid_now_amount,
  il.remaining_amount,
  il.currency,
  il.notes,
  il.created_at,
  il.updated_at
from public.invoice_lock il
left join public.leads l on l.id = il.lead_id
order by updated_at desc;
