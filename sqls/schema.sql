--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2024-05-18 15:39:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 219 (class 1255 OID 104052)
-- Name: all_libros_by_autor(bigint); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.all_libros_by_autor(IN autor_id bigint, OUT total integer)
    LANGUAGE plpgsql
    AS $$
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


ALTER PROCEDURE public.all_libros_by_autor(IN autor_id bigint, OUT total integer) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 104339)
-- Name: calcula_promedio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcula_promedio() RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.calcula_promedio() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 104403)
-- Name: autores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autores (
    id bigint NOT NULL,
    email character varying(255),
    nombre character varying(255)
);


ALTER TABLE public.autores OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 104402)
-- Name: autores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autores_id_seq OWNER TO postgres;

--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 214
-- Name: autores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autores_id_seq OWNED BY public.autores.id;


--
-- TOC entry 216 (class 1259 OID 104411)
-- Name: autores_libros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autores_libros (
    id_autor bigint NOT NULL,
    id_libro bigint NOT NULL
);


ALTER TABLE public.autores_libros OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 104415)
-- Name: libros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libros (
    fecha_publicacion date,
    id bigint NOT NULL,
    tipo character varying(255),
    titulo character varying(255)
);


ALTER TABLE public.libros OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 104414)
-- Name: libros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.libros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.libros_id_seq OWNER TO postgres;

--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 217
-- Name: libros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.libros_id_seq OWNED BY public.libros.id;


--
-- TOC entry 3184 (class 2604 OID 104406)
-- Name: autores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores ALTER COLUMN id SET DEFAULT nextval('public.autores_id_seq'::regclass);


--
-- TOC entry 3185 (class 2604 OID 104418)
-- Name: libros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros ALTER COLUMN id SET DEFAULT nextval('public.libros_id_seq'::regclass);


--
-- TOC entry 3187 (class 2606 OID 104410)
-- Name: autores autores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores
    ADD CONSTRAINT autores_pkey PRIMARY KEY (id);


--
-- TOC entry 3189 (class 2606 OID 104422)
-- Name: libros libros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libros
    ADD CONSTRAINT libros_pkey PRIMARY KEY (id);


--
-- TOC entry 3190 (class 2606 OID 104423)
-- Name: autores_libros fk5prymp3jwu4arvbab5dsb9sko; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores_libros
    ADD CONSTRAINT fk5prymp3jwu4arvbab5dsb9sko FOREIGN KEY (id_libro) REFERENCES public.libros(id);


--
-- TOC entry 3191 (class 2606 OID 104428)
-- Name: autores_libros fkh2xhw7cc0fty4jwf2osxihp9k; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autores_libros
    ADD CONSTRAINT fkh2xhw7cc0fty4jwf2osxihp9k FOREIGN KEY (id_autor) REFERENCES public.autores(id);


-- Completed on 2024-05-18 15:39:34

--
-- PostgreSQL database dump complete
--

