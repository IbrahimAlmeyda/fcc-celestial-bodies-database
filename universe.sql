--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: black_hole; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.black_hole (
    black_hole_id integer NOT NULL,
    galaxy_id integer,
    black_hole_type_id integer,
    name character varying(150) NOT NULL,
    mass_solar numeric(20,4),
    spin numeric(5,4),
    electric_charge_coulombs numeric(24,4),
    is_central boolean,
    description text,
    CONSTRAINT black_hole_central_ck CHECK (((is_central IS NOT TRUE) OR (galaxy_id IS NOT NULL))),
    CONSTRAINT black_hole_mass_solar_ck CHECK ((mass_solar > (0)::numeric)),
    CONSTRAINT black_hole_spin_ck CHECK (((spin >= ('-1'::integer)::numeric) AND (spin <= (1)::numeric)))
);


ALTER TABLE public.black_hole OWNER TO freecodecamp;

--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.black_hole ALTER COLUMN black_hole_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.black_hole_black_hole_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: black_hole_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.black_hole_type (
    black_hole_type_id integer NOT NULL,
    name character varying(150) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.black_hole_type OWNER TO freecodecamp;

--
-- Name: black_hole_type_black_hole_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.black_hole_type ALTER COLUMN black_hole_type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.black_hole_type_black_hole_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(150) NOT NULL,
    morphological_type character varying(50) NOT NULL,
    diameter_ly numeric(14,2),
    estimated_stars bigint,
    rotation_description text,
    description text,
    CONSTRAINT galaxy_diameter_ck CHECK ((diameter_ly > (0)::numeric)),
    CONSTRAINT galaxy_estimated_stars_ck CHECK ((estimated_stars >= 0))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.galaxy ALTER COLUMN galaxy_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.galaxy_galaxy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(150) NOT NULL,
    diameter_km numeric(12,3),
    orbital_period_days numeric(18,5),
    is_spherical boolean,
    description text,
    CONSTRAINT moon_diameter_km_ck CHECK ((diameter_km > (0)::numeric)),
    CONSTRAINT moon_orbial_period_days_ck CHECK ((orbital_period_days > (0)::numeric))
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.moon ALTER COLUMN moon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.moon_moon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(150) NOT NULL,
    planet_type character varying(50) NOT NULL,
    mass_earth numeric(18,6),
    radius_earth numeric(14,6),
    orbital_period_days numeric(18,5),
    mean_temperature_k integer,
    is_potentially_habitable boolean,
    description text,
    CONSTRAINT planet_mass_earth_ck CHECK ((mass_earth > (0)::numeric)),
    CONSTRAINT planet_mean_temperature_k_ck CHECK ((mean_temperature_k >= 0)),
    CONSTRAINT planet_orbital_period_days_ck CHECK ((orbital_period_days > (0)::numeric)),
    CONSTRAINT planet_radius_earth_ck CHECK ((radius_earth > (0)::numeric))
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.planet ALTER COLUMN planet_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planet_planet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(150) NOT NULL,
    spectral_type character varying(10),
    mass_solar numeric(14,6),
    radius_solar numeric(14,6),
    surface_temperature_k integer,
    age_billion_years numeric(9,5),
    description text,
    CONSTRAINT star_age_billion_years_ck CHECK ((age_billion_years >= (0)::numeric)),
    CONSTRAINT star_mass_solar_ck CHECK ((mass_solar > (0)::numeric)),
    CONSTRAINT star_radius_solar_ck CHECK ((radius_solar > (0)::numeric)),
    CONSTRAINT star_sf_temp_k_ck CHECK ((surface_temperature_k > 0))
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.star ALTER COLUMN star_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.star_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: black_hole; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.black_hole OVERRIDING SYSTEM VALUE VALUES (1, 1, 3, 'Sagittarius A*', 4000000.0000, NULL, NULL, true, 'Supermassive black hole at the center of the Milky Way.');
INSERT INTO public.black_hole OVERRIDING SYSTEM VALUE VALUES (2, 4, 3, 'M87*', 6500000000.0000, NULL, NULL, true, 'Supermassive black hole imaged by the Event Horizon Telescope.');
INSERT INTO public.black_hole OVERRIDING SYSTEM VALUE VALUES (3, 1, 1, 'Cygnus X-1', 21.2000, NULL, NULL, false, 'Stellar-mass black hole in an X-ray binary system.');


--
-- Data for Name: black_hole_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.black_hole_type OVERRIDING SYSTEM VALUE VALUES (1, 'Stellar', 'Black holes formed primarily from the collapse of massive stars, typically with masses of a few to around 100 solar masses.');
INSERT INTO public.black_hole_type OVERRIDING SYSTEM VALUE VALUES (2, 'Intermediate', 'Black holes with masses between stellar and supermassive black holes, approximately hundreds to hundreds of thousands of solar masses.');
INSERT INTO public.black_hole_type OVERRIDING SYSTEM VALUE VALUES (3, 'Supermassive', 'Black holes with masses ranging from hundreds of thousands to billions of solar masses, commonly found in galactic centers.');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (1, 'Milky Way', 'Barred Spiral', 100000.00, 200000000000, 'Differential rotation of stars around the galactic center.', 'Galaxy containing the Solar System and the central black hole Sagittarius A*.');
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (2, 'Andromeda Galaxy', 'Spiral', 220000.00, 1000000000000, 'Rotating stellar disk with spiral structure.', 'Also known as M31, a major galaxy in the Local Group.');
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (3, 'Triangulum Galaxy', 'Spiral', 60000.00, 40000000000, 'Rotating stellar disk with well-defined spiral arms.', 'Also known as M33, a spiral galaxy in the Local Group.');
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (4, 'Messier 87', 'Elliptical', 120000.00, NULL, NULL, 'Giant elliptical galaxy in the Virgo Cluster, hosting the supermassive black hole M87*.');
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (5, 'Large Magellanic Cloud', 'Irregular', 15000.00, NULL, NULL, 'Irregular dwarf galaxy near the Milky Way, containing the Tarantula Nebula.');
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (6, 'Small Magellanic Cloud', 'Irregular', NULL, NULL, NULL, 'Irregular dwarf galaxy associated with the Milky Way and the Large Magellanic Cloud.');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (1, 3, 'Moon', 3474.000, 27.32000, true, 'Earth''s only major natural satellite.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (2, 4, 'Phobos', 22.000, 0.32000, false, 'Small irregularly shaped moon orbiting close to Mars.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (3, 4, 'Deimos', 12.000, 1.26000, false, 'Small irregularly shaped outer moon of Mars.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (4, 5, 'Io', 3643.000, 1.77000, true, 'Volcanically active Galilean moon.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (5, 5, 'Europa', 3122.000, 3.55000, true, 'Icy Galilean moon with a subsurface ocean.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (6, 5, 'Ganymede', 5268.000, 7.15000, true, 'Largest natural satellite in the Solar System.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (7, 5, 'Callisto', 4820.000, 16.69000, true, 'Heavily cratered Galilean moon.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (8, 6, 'Titan', 5151.000, 15.95000, true, 'Large moon with a dense atmosphere and methane lakes.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (9, 6, 'Enceladus', 504.000, 1.37000, true, 'Icy moon with water-rich plumes.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (10, 6, 'Mimas', 396.000, 0.94000, true, 'Icy moon known for its large Herschel crater.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (11, 6, 'Tethys', 1062.000, 1.89000, true, 'Icy moon with a prominent impact crater.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (12, 6, 'Dione', 1123.000, 2.74000, true, 'Icy satellite with extensive surface fractures.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (13, 6, 'Rhea', 1527.000, 4.52000, true, 'Second-largest moon of Saturn.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (14, 7, 'Miranda', 472.000, 1.41000, true, 'Moon with unusually varied surface terrain.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (15, 7, 'Ariel', 1158.000, 2.52000, true, 'Icy moon with valleys and surface fractures.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (16, 7, 'Umbriel', 1169.000, 4.14000, true, 'Dark and heavily cratered Uranian moon.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (17, 7, 'Titania', 1578.000, 8.71000, true, 'Largest moon of Uranus.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (18, 7, 'Oberon', 1523.000, 13.46000, true, 'Large outer moon of Uranus.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (19, 8, 'Triton', 2710.000, 5.88000, true, 'Large moon with a retrograde orbit.');
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (20, 8, 'Proteus', 420.000, 1.12000, false, 'Irregularly shaped moon of Neptune.');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (1, 1, 'Mercury', 'Terrestrial', 0.055300, 0.383000, 87.97000, 440, false, 'Smallest planet in the Solar System.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (2, 1, 'Venus', 'Terrestrial', 0.815000, 0.949000, 224.70000, 737, false, 'Terrestrial planet with a dense carbon dioxide atmosphere.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (3, 1, 'Earth', 'Terrestrial', 1.000000, 1.000000, 365.26000, 288, true, 'Third planet from the Sun and the only known planet supporting life.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (4, 1, 'Mars', 'Terrestrial', 0.107000, 0.532000, 686.98000, 210, NULL, 'Rocky planet with polar ice caps and evidence of ancient liquid water.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (5, 1, 'Jupiter', 'Gas Giant', 317.800000, 11.210000, 4332.59000, 165, false, 'Largest planet in the Solar System.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (6, 1, 'Saturn', 'Gas Giant', 95.200000, 9.450000, 10759.22000, 134, false, 'Gas giant known for its prominent ring system.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (7, 1, 'Uranus', 'Ice Giant', 14.500000, 4.010000, 30688.50000, 76, false, 'Ice giant with an extreme axial tilt.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (8, 1, 'Neptune', 'Ice Giant', 17.100000, 3.880000, 60182.00000, 72, false, 'Distant ice giant with powerful atmospheric winds.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (9, 2, 'Proxima Centauri b', 'Super Earth', 1.055000, 1.020000, 11.18465, NULL, NULL, 'Nearby exoplanet orbiting Proxima Centauri.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (10, 2, 'Proxima Centauri d', 'Terrestrial', 0.260000, NULL, 5.12000, NULL, NULL, 'Low-mass exoplanet orbiting Proxima Centauri.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (11, 6, 'Barnard b', 'Terrestrial', 0.299000, 0.720000, 3.15000, NULL, NULL, 'Short-period exoplanet orbiting Barnard''s Star.');
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (12, 6, 'Barnard c', 'Terrestrial', NULL, NULL, 4.12000, NULL, NULL, 'Exoplanet orbiting Barnard''s Star.');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (1, 1, 'Sun', 'G2V', 1.000000, 1.000000, 5772, 4.60000, 'Star at the center of the Solar System.');
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (2, 1, 'Proxima Centauri', 'M5.5V', 0.120000, 0.140000, 3296, NULL, 'Red dwarf and the closest known star to the Sun.');
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (3, 1, 'Alpha Centauri A', 'G2V', 1.100000, 1.230000, 5790, NULL, 'Sun-like star in the Alpha Centauri system.');
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (4, 1, 'Alpha Centauri B', 'K1V', 0.910000, 0.860000, 5260, NULL, 'Companion star to Alpha Centauri A.');
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (5, 2, 'M31-V1', NULL, NULL, NULL, NULL, NULL, 'Cepheid variable star studied by Edwin Hubble in the Andromeda Galaxy.');
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (6, 1, 'Barnard''s Star', 'M4V', NULL, NULL, NULL, NULL, 'Nearby red dwarf star in the constellation Ophiuchus.');


--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.black_hole_black_hole_id_seq', 3, true);


--
-- Name: black_hole_type_black_hole_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.black_hole_type_black_hole_type_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: black_hole black_hole_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_name_key UNIQUE (name);


--
-- Name: black_hole black_hole_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_pkey PRIMARY KEY (black_hole_id);


--
-- Name: black_hole_type black_hole_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole_type
    ADD CONSTRAINT black_hole_type_name_key UNIQUE (name);


--
-- Name: black_hole_type black_hole_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole_type
    ADD CONSTRAINT black_hole_type_pkey PRIMARY KEY (black_hole_type_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: idx_black_hole_galaxy_id; Type: INDEX; Schema: public; Owner: freecodecamp
--

CREATE INDEX idx_black_hole_galaxy_id ON public.black_hole USING btree (galaxy_id);


--
-- Name: idx_black_hole_type_id; Type: INDEX; Schema: public; Owner: freecodecamp
--

CREATE INDEX idx_black_hole_type_id ON public.black_hole USING btree (black_hole_type_id);


--
-- Name: idx_moon_planet_id; Type: INDEX; Schema: public; Owner: freecodecamp
--

CREATE INDEX idx_moon_planet_id ON public.moon USING btree (planet_id);


--
-- Name: idx_planet_star_id; Type: INDEX; Schema: public; Owner: freecodecamp
--

CREATE INDEX idx_planet_star_id ON public.planet USING btree (star_id);


--
-- Name: idx_star_galaxy_id; Type: INDEX; Schema: public; Owner: freecodecamp
--

CREATE INDEX idx_star_galaxy_id ON public.star USING btree (galaxy_id);


--
-- Name: black_hole black_hole_galaxy_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_galaxy_fk FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: black_hole black_hole_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_type_fk FOREIGN KEY (black_hole_type_id) REFERENCES public.black_hole_type(black_hole_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: moon moon_planet_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_fk FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: planet planet_star_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_fk FOREIGN KEY (star_id) REFERENCES public.star(star_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: star star_galaxy_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_fk FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

