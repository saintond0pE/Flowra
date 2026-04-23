-- Newest-first utilities for Flowra tables
-- Run once in Supabase SQL Editor.
-- This does NOT change table storage order (Postgres tables are unordered by design).
-- It gives fast newest-first queries and ready-to-use views.

-- Performance indexes for newest-first scans
create index if not exists idx_projects_created_at_desc
on projects (created_at desc);

create index if not exists idx_tasks_updated_at_desc
on tasks (updated_at desc);

create index if not exists idx_leads_created_at_desc
on leads (created_at desc);

create index if not exists idx_feedback_created_at_desc
on feedback (created_at desc);

create index if not exists idx_team_logs_created_at_desc
on team_logs (created_at desc);

-- Optional helper views (always newest at top)
create or replace view projects_newest as
select *
from projects
order by created_at desc, id desc;

create or replace view tasks_newest as
select *
from tasks
order by updated_at desc, id desc;

create or replace view leads_newest as
select *
from leads
order by created_at desc, id desc;

create or replace view feedback_newest as
select *
from feedback
order by created_at desc, id desc;

create or replace view team_logs_newest as
select *
from team_logs
order by created_at desc, id desc;
