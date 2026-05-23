-- SQL migration script to update invoice_lock table for revenue tracking

-- 1. Add new columns to the existing table if they do not exist
alter table public.invoice_lock add column if not exists total_amount numeric default 0;
alter table public.invoice_lock add column if not exists paid_amount numeric default 0;
alter table public.invoice_lock add column if not exists invoice_status text default 'Sent';
alter table public.invoice_lock add column if not exists payment_status text default 'Payment Pending';

-- 2. Recreate view to include these new fields along with all existing fields (invoice_link, free_edit_mode, etc.)
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
  il.invoice_link,
  il.free_edit_mode,
  -- NEW FIELDS:
  il.total_amount,
  il.paid_amount,
  il.invoice_status,
  il.payment_status,
  il.created_at,
  il.updated_at
from public.invoice_lock il
left join public.leads l on l.id = il.lead_id
order by updated_at desc;
