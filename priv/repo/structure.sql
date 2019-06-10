--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.17
-- Dumped by pg_dump version 9.5.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: reciperi_ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reciperi_ingredients (
    id bigint NOT NULL,
    name character varying(40),
    inserted_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    description text,
    price numeric
);


--
-- Name: reciperi_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reciperi_ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reciperi_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reciperi_ingredients_id_seq OWNED BY public.reciperi_ingredients.id;


--
-- Name: reciperi_recipe_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reciperi_recipe_items (
    id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    ingredient_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT now() NOT NULL
);


--
-- Name: reciperi_recipe_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reciperi_recipe_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reciperi_recipe_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reciperi_recipe_items_id_seq OWNED BY public.reciperi_recipe_items.id;


--
-- Name: reciperi_recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reciperi_recipes (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    inserted_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT now() NOT NULL
);


--
-- Name: reciperi_recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reciperi_recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reciperi_recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reciperi_recipes_id_seq OWNED BY public.reciperi_recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_ingredients ALTER COLUMN id SET DEFAULT nextval('public.reciperi_ingredients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipe_items ALTER COLUMN id SET DEFAULT nextval('public.reciperi_recipe_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipes ALTER COLUMN id SET DEFAULT nextval('public.reciperi_recipes_id_seq'::regclass);


--
-- Name: reciperi_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_ingredients
    ADD CONSTRAINT reciperi_ingredients_pkey PRIMARY KEY (id);


--
-- Name: reciperi_recipe_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipe_items
    ADD CONSTRAINT reciperi_recipe_items_pkey PRIMARY KEY (id, recipe_id, ingredient_id);


--
-- Name: reciperi_recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipes
    ADD CONSTRAINT reciperi_recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: recipe_id_ingredient_id_unique_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX recipe_id_ingredient_id_unique_index ON public.reciperi_recipe_items USING btree (recipe_id, ingredient_id);


--
-- Name: reciperi_recipe_items_ingredient_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reciperi_recipe_items_ingredient_id_index ON public.reciperi_recipe_items USING btree (ingredient_id);


--
-- Name: reciperi_recipe_items_recipe_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reciperi_recipe_items_recipe_id_index ON public.reciperi_recipe_items USING btree (recipe_id);


--
-- Name: reciperi_recipe_items_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipe_items
    ADD CONSTRAINT reciperi_recipe_items_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.reciperi_ingredients(id) ON DELETE CASCADE;


--
-- Name: reciperi_recipe_items_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reciperi_recipe_items
    ADD CONSTRAINT reciperi_recipe_items_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.reciperi_recipes(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20190224113401), (20190414083920), (20190414085137), (20190610102919);

