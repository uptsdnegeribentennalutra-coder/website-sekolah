-- Jalankan SEKALI di Supabase > SQL Editor.
-- Script ini menambah kolom profil, hak akses admin, dan policy Storage.

alter table public.profil_sekolah add column if not exists peserta_didik integer default 246;
alter table public.profil_sekolah add column if not exists jumlah_guru integer default 15;
alter table public.profil_sekolah add column if not exists jumlah_tendik integer default 6;
alter table public.profil_sekolah add column if not exists rombel integer default 6;
alter table public.profil_sekolah add column if not exists tagline text;
alter table public.profil_sekolah add column if not exists hero_text text;

-- Admin terautentikasi boleh mengelola isi database.
create policy "Admin authenticated manage profil" on public.profil_sekolah for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage gtk" on public.gtk for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage alumni" on public.alumni for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage berita" on public.berita for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage kegiatan" on public.kegiatan for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage prestasi" on public.prestasi for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage galeri" on public.galeri for all to authenticated using (true) with check (true);
create policy "Admin authenticated manage dokumen" on public.dokumen for all to authenticated using (true) with check (true);

-- Storage: pengunjung dapat membaca media publik; admin login dapat upload, ubah, dan hapus.
create policy "Public read school media" on storage.objects for select to public using (bucket_id in ('foto-gtk','foto-alumni','berita','kegiatan','prestasi','galeri'));
create policy "Admin upload school media" on storage.objects for insert to authenticated with check (bucket_id in ('foto-gtk','foto-alumni','berita','kegiatan','prestasi','galeri','dokumen'));
create policy "Admin update school media" on storage.objects for update to authenticated using (bucket_id in ('foto-gtk','foto-alumni','berita','kegiatan','prestasi','galeri','dokumen')) with check (bucket_id in ('foto-gtk','foto-alumni','berita','kegiatan','prestasi','galeri','dokumen'));
create policy "Admin delete school media" on storage.objects for delete to authenticated using (bucket_id in ('foto-gtk','foto-alumni','berita','kegiatan','prestasi','galeri','dokumen'));

update public.profil_sekolah
set peserta_didik=246,jumlah_guru=15,jumlah_tendik=6,rombel=6,
    tagline='Menginspirasi Negeri',
    hero_text='Mendidik, membimbing, dan menginspirasi generasi penerus yang kreatif, berkarakter, berdaya saing, dan berakhlak mulia.'
where nama_sekolah='UPT SD Negeri 029 Bentenna';
