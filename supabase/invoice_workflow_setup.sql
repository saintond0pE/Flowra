-- Invoice workflow table for dashboard schedule-invoice flow
create table if not exists invoices (
  id text primary key,
  lead_id text references leads(id) on delete set null,
  lead_name text,
  project_id text references projects(id) on delete set null,
  project_name text,
  project_ids jsonb default '[]'::jsonb,
  project_names jsonb default '[]'::jsonb,
  modules text[] default '{}',
  payment_mode text,
  payment_method text default 'upi',
  base_amount numeric default 0,
  addon_amount numeric default 0,
  current_charge_base numeric default 0,
  previous_locked_total numeric default 0,
  locked_total_amount numeric default 0,
  upfront_percent numeric default 25,
  upfront_amount numeric default 0,
  partial_percent_of_upfront numeric default 0,
  due_now_amount numeric default 0,
  paid_now_amount numeric default 0,
  remaining_amount numeric default 0,
  currency text default 'INR',
  notes text,
  created_at timestamptz default now()
);

-- Backward-compatible upgrades for existing tables.
alter table invoices add column if not exists payment_method text default 'upi';
alter table invoices add column if not exists current_charge_base numeric default 0;
alter table invoices add column if not exists partial_percent_of_upfront numeric default 0;
alter table invoices add column if not exists paid_now_amount numeric default 0;
alter table invoices add column if not exists remaining_amount numeric default 0;
alter table invoices add column if not exists project_ids jsonb default '[]'::jsonb;
alter table invoices add column if not exists project_names jsonb default '[]'::jsonb;
alter table invoices add column if not exists previous_locked_total numeric default 0;

alter table invoices enable row level security;
drop policy if exists public_all on invoices;
create policy public_all on invoices for all using (true) with check (true);

create index if not exists idx_invoices_created_at_desc on invoices (created_at desc);
create index if not exists idx_invoices_lead_id on invoices (lead_id);
create index if not exists idx_invoices_project_id on invoices (project_id);
