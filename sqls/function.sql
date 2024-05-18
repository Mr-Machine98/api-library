/* función que calcula el promedio de libros por
autor en la biblioteca.*/
create or replace function calcula_promedio() returns text as $$
	declare
		numero_total_autores int;
		numero_total_libros int;
		promedio numeric;
		respuesta text;

		begin
			
			/*Buscamos los totales de cada entidad*/
			select count(*) into numero_total_autores from autores;
			select count(*) into numero_total_libros from libros;
			
			promedio := numero_total_libros / numero_total_autores;
			respuesta := 'Promedio de libros por autor: ' || promedio;
			
			return respuesta;
		end;
$$ language plpgsql;

/*llamamos la función*/
select calcula_promedio();