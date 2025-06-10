
-- Tabela de Lançamentos de Livros
create table livros(
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  titulo text,
  autor text,
  categoria text check (categoria in ('romance','ficcao','estudo','outros')),
  data_locacao date not null,
  data_devolucao date,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

--Habilitar segurança do supabase
alter table livros enable row level security;
--Política para cada usuário somente ver os seus próprios lançamentos
create policy "Permitir acesso ao próprio usuário no cadastro de livros"
  on livros for select
on livros for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);