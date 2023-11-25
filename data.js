db.consumidores.insertMany(
    [
        {
            "_id": ObjectId('655fdc0bac03095241774e31'),
            "perfil": "url",
            "distrito":
                {
                "nombre_distrito":"Los Olivos",
                "departamento": "Lima"
                },
            "nombre":"Natalia",
            "apellido": "Almendra",
            //"_id":"1"
        },
        {
            "_id": ObjectId('655fdc0bac03095241774e32'),
            "perfil": "url",
            "distrito":
                {
                "nombre_distrito":"Pueblo Libre",
                "departamento": "Lima"
                },
            "nombre":"Jorge",
            "apellido": "Guti",
            //"_id":"2"
        },
        {
            "_id":ObjectId('655fdc0bac03095241774e33'),
            "perfil": "url",
            "distrito":
                {
                "nombre_distrito":"Plaza Central",
                "departamento": "Arequipa"
                },
            "nombre":"Andres",
            "apellido": "Palomino",
            //"_id":"3"
        }
    ]
)

use ('ServiciosTecnicos')
db.consumidores.find()
db.consumidores.count()

// COLECCION detallesConsumidores

use('ServiciosTecnicos')
db.detallesConsumidores.insertMany(
    [
        {
            "edad": 28,
            "genero":"Femenina",
            "contacto":974581281,
            "correo":"natalia_almendra@gmail.com",
            "estado":"Reportada",
            "consumidor_id":ObjectId('655fdc0bac03095241774e31')
        },
        {
            "edad": 19,
            "genero":"Masculino",
            "contacto":928591825,
            "correo":"jorge_guti@gmail.com",
            "estado":"Activa",
            "consumidor_id":ObjectId('655fdc0bac03095241774e32')
        },
        {
            "edad": 54,
            "genero":"Masculino",
            "contacto": 927457812,
            "correo":"andres_palomino@gmail.com",
            "estado":"Bloqueado",
            "consumidor_id":ObjectId('655fdc0bac03095241774e33')
        }
    ]
)

use ('ServiciosTecnicos')
db.detallesConsumidores.find()

// Coleccion tecnicos

use ('ServiciosTecnicos')
db.tecnicos.insertMany(
    [
        {
            "_id": ObjectId('655fe3af93bdc12c265d711e'),
            "distrito":{
                "departamento":"Lima",
                "nombre_distrito":"Los Olivos"
            },
            "especialidad":"Gasfitero",
            "perfil":"url",
            "nombre":"Benjamin",
            "apellido":"Mendoza",
            "genero":"Masculino"
        },
        {
            "_id": ObjectId('655fe3af93bdc12c265d711f'),
            "distrito":{
                "departamento":"Lima",
                "nombre_distrito":"Pueblo Libre"
            },
            "especialidad":"Electronico",
            "perfil":"url",
            "nombre":"Juan",
            "apellido":"Zebarra",
            "genero":"Masculino"
        },
        {
            "_id": ObjectId('655fe3af93bdc12c265d7120'),
            "distrito":{
                "departamento":"Arequipa",
                "nombre_distrito":"Plaza Central"
            },
            "especialidad":"Mecanico",
            "perfil":"url",
            "nombre":"Andrea",
            "apellido":"Martinez",
            "genero":"Femenino"
        }
    ]
)

use ('ServiciosTecnicos')
db.tecnicos.find()

// Coleccion detalleTecnicos

use ('ServiciosTecnicos')
db.detalleTecnicos.insertMany(
    [
        {
            "edad": 29,
            "contacto":968198234,
            "correo_electronico":"benjamin_mendoza@gmail.com",
            "disponibilidad": "DISPONIBLE",
            "estado":"Activa",
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711e'),
            "resenias":[
                {
                    "consumidor": ObjectId('655fdc0bac03095241774e31'),
                    "contenido": "Buen servicio, disciplina y actitud",
                    "puntaje": 4,
                    "fecha": new Date("2022-04-22")
                },
                {
                    "consumidor": ObjectId('655fdc0bac03095241774e32'),
                    "contenido": "Trabajador y mucha experiencia en el rubro",
                    "puntaje": 5,
                    "fecha": new Date("2022-09-24")
                }
            ]   
        },
        {
            "edad": 22,
            "contacto":927568185,
            "correo_electronico":"juan_zebarra@gmail.com",
            "disponibilidad": "DISPONIBLE",
            "estado":"Reportada",
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711f'),
            "resenias":[
                {
                    "consumidor": ObjectId('655fdc0bac03095241774e31'),
                    "contenido": "Mal servicio, no tiene experiencia en lo que es Servicios Tecnicos.",
                    "puntaje": 0,
                    "fecha": new Date("2023-04-26")
                },
                {
                    "consumidor": ObjectId('655fdc0bac03095241774e32'),
                    "contenido": "Me insulto en la cara justo despues de decirle que su trabajo fue un desastre",
                    "puntaje": 0,
                    "fecha": new Date("2023-03-13")
                }
            ]
        },
        {
            "edad": 28,
            "contacto":956812398,
            "correo_electronico":"andrea_martinez@gmail.com",
            "disponibilidad": "DISPONIBLE",
            "estado":"Activa",
            "tecnicoId": ObjectId('655fe3af93bdc12c265d7120'),
            "resenias":[
                {
                    "consumidor": ObjectId('655fdc0bac03095241774e33'),
                    "contenido": "Gran actitud durante el trabajo, esta dispuesta a dar lo mejor de sí",
                    "puntaje": 5,
                    "fecha": new Date("05-04-2023")
                }
            ]
        }
    ]
)

use('ServiciosTecnicos')
db.detalleTecnicos.find()


// Coleccion Resenias Tecnicos
use('ServiciosTecnicos')
db.reseniasTecnicos.insertMany(
    [
        {
            "consumidor": ObjectId('655fdc0bac03095241774e31'),
            "contenido": "Buen servicio, disciplina y actitud",
            "puntaje": 4,
            "fecha": new Date("2022-04-22"),
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711e')
        },
        {
            "consumidor": ObjectId('655fdc0bac03095241774e32'),
            "contenido": "Trabajador y mucha experiencia en el rubro",
            "puntaje": 5,
            "fecha": new Date("2022-09-24"),
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711e')
        },
        {
            "consumidor": ObjectId('655fdc0bac03095241774e31'),
            "contenido": "Mal servicio, no tiene experiencia en lo que es Servicios Tecnicos.",
            "puntaje": 0,
            "fecha": new Date("2023-04-26"),
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711f')
        },
        {
            "consumidor": ObjectId('655fdc0bac03095241774e32'),
            "contenido": "Me insulto en la cara justo despues de decirle que su trabajo fue un desastre",
            "puntaje": 0,
            "fecha": new Date("2023-03-13"),
            "tecnicoId": ObjectId('655fe3af93bdc12c265d711f')
        },
        {
            "consumidor": ObjectId('655fdc0bac03095241774e33'),
            "contenido": "Gran actitud durante el trabajo, esta dispuesta a dar lo mejor de sí",
            "puntaje": 5,
            "fecha": new Date("05-04-2023"),
            "tecnicoId": ObjectId('655fe3af93bdc12c265d7120')
        }
    ]
)