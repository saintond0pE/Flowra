-- Newest-first utilities for Flowra tables
-- Run once in Supabase SQL Editor.
-- This does NOT change table storage order (Postgres tables are unordered by design).
-- It gives fast newest-first queries and ready-to-use views.

-- Ensure projects table has lead_id so invoice joins are stable
alter table projects
add column if not exists lead_id text;

-- Backfill lead_id for older rows where project id already equals lead id
update projects p
set lead_id = p.id
where p.lead_id is null
	and exists (select 1 from leads l where l.id = p.id);

-- Optional FK (safe if IDs match existing leads)
do $$
begin
	if not exists (
		select 1
		from pg_constraint
		where conname = 'projects_lead_id_fkey'
	) then
		alter table projects
		add constraint projects_lead_id_fkey
		foreign key (lead_id) references leads(id) on delete set null;
	end if;
end $$;

create index if not exists idx_projects_lead_id on projects (lead_id);

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

-- Invoice-oriented view: lead + project + module list (no task-level lines)
create or replace view v_lead_project_modules as
select
	l.id as lead_id,
	l.name as lead_name,
	l.email as lead_email,
	l.number as lead_number,
	p.id as project_id,
	p.project_name,
	coalesce(array_remove(array_agg(distinct t.module order by t.module), null), '{}') as modules,
	p.created_at as project_created_at
from projects p
left join leads l on l.id = p.lead_id
left join tasks t on t.project_id = p.id
group by l.id, l.name, l.email, l.number, p.id, p.project_name, p.created_at
order by p.created_at desc, p.id desc;
