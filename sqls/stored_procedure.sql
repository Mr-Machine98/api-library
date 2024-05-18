/*
Crear un procedimiento almacenado en PL/SQL que reciba el ID
de un autor y devuelva la cantidad
total de libros escritos por ese autor.
*/
create or replace procedure all_libros_by_autor(in autor_id bigint, out total int) language plpgsql as $$
	declare
		/* Recuperamos los libros asociados al autor con ayuda de esta var*/
		rec record;
		begin
			/*cantidad total de libros*/
			total := 0;
			for rec in (select * from autores_libros al where al.id_autor = autor_id) loop
				total := total + 1;
				raise notice 'id_autor: %, id_libro: %', rec.id_autor, rec.id_libro;
			end loop;
			raise notice 'total: %', total;
		end;
$$;

-- Con este bloque ejecutas el procedure
do $$
	declare
		total_libros int;
	begin
		call all_libros_by_autor(autor_id => 5, total => total_libros);
		RAISE NOTICE 'El autor tiene % libros.', total_libros;
	end
$$;