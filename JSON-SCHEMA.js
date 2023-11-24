use techAdvancesServices

db.createCollection('tecnicos', {
    validator:{
        $jsonSchema: {
            bsonType: 'object',
            required: ['distrito', 'especialidad', 'perfil', 'nombre', 'apellido', 'genero'],
            properties:{
                distrito: {
                    bsonType: 'object',
                    required:['departamento', 'nombre_distrito'],
                    properties:{
                        departamento:{
                            bsonType: 'string',
                        },
                        nombre_distrito:{
                            bsonType: 'string'
                        }
                    }
                },
                especialidad: {
                    bsonType: 'string',
                },
                perfil: {
                    bsonType: 'string'
                },
                nombre: {
                    bsonType: 'string'
                },
                apellido: {
                    bsonType: 'string'
                },
                genero: {
                    bsonType: 'string'
                },
            }
        }
    }
})

db.createCollection('detalleTecnicos', {
    validator:{
        $jsonSchema: {
            bsonType: 'object',
            required: [ 'edad','contacto', 'correo_electronico', 'disponibilidad', 'estado', 'tecnicoId', 'resenias'],
            properties: {
                edad: {
                    bsonType: 'int'
                },
                contacto: {
                    bsonType: 'int'
                },
                correo_electronico:{
                    bsonType: 'string'
                },
                disponibilidad:{
                    bsonType: 'string'
                },
                estado:{
                    bsonType: 'string'
                },
                tecnicoId:{
                    bsonType: 'objectId'
                },
                resenias:{
                    bsonType: 'array',
                    minItems: 0,
                    maxItems: 5,
                    items:{
                        bsonType: 'object',
                        required: ['consumidor', 'contenido', 'puntaje', 'fecha'],
                        properties:{
                            consumidor:{
                                bsonType: 'objectId'
                            },
                            contenido:{
                                bsonType: 'string'
                            },
                            puntaje:{
                                bsonType: 'int'
                            },
                            fecha:{
                                bsonType: 'date'
                            }
                        }
                    }
                }
            }
        }
    }
})

db.createCollection('reseniasTecnicos', {
    validator:{
        $jsonSchema:{
            bsonType: 'object',
            required: ['consumidor', 'contenido', 'puntaje', 'fecha'],
            properties:{
                consumidor:{
                    bsonType: 'objectId'
                },
                contenido:{
                    bsonType: 'string'
                },
                puntaje:{
                    bsonType: 'int'
                },
                fecha:{
                    bsonType: 'date'
                },
                tecnicoId:{
                    bsonType: 'objectId'
                }
            }
        }
    }
})

db.createCollection('consumidores', {
    validator:{
        $jsonSchema:{
            bsonType: 'object',
            required: ['perfil', 'distrito', 'nombre', 'apellido'],
            properties:{
                perfil:{
                    bsonType: 'string',
                },
                distrito:{
                    bsonType: 'object',
                    required:['nombre_distrito','departamento'],
                    properties:{
                        nombre_distrito:{
                            bsonType: 'string',
                        },
                        departamento:{
                            bsonType: 'string',
                        }
                    }
                },
                nombre:{
                    bsonType: 'string',
                },
                apellido:{
                    bsonType: 'string',
                },

            }
        }
    }
})

db.createCollection('detallesConsumidores', {
    validator:{
        $jsonSchema:{
            bsonType: 'object',
            required: ['edad', 'genero', 'contacto','correo','estado', 'consumidor_id'],
            properties:{
                edad:{
                    bsonType: 'int'
                },
                genero:{
                    bsonType: 'string'
                },
                contacto:{
                    bsonType: 'int'
                },
                correo:{
                    bsonType: 'string'
                },
                estado:{
                    bsonType: 'string'
                },
                consumidor_id:{
                    bsonType: 'objectId'
                }
            }
        }
    }
})
