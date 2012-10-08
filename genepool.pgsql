
BEGIN;

create schema genepool;

set search_path to genepool;

create table person (
    id serial primary key,
    name text not null,
    gender char(1) check(gender IN ('m' , 'f')),
    birthdate date,
    birthplace text,
    place_of_birth date,
    place_of_death text,
    comments text,
    father integer not null,
    mother integer not null,
    constraint fk_person_father
    foreign key(father) references person(id),
    constraint fk_person_mother
    foreign key(mother) references person(id)
);    

COMMIT;

