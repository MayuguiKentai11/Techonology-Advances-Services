//Consumidores con mas de una reseña con un puntaje mayor que 3

db.reseniasTecnicos.aggregate([
    {$match: {
        'puntaje':{$gt: 3} 
    }},
    {$group: {
        _id: '$consumidor',
        quantity: {$count: {}}
    }},
    {$match: {
        'quantity': {$gt: 1}
    }},
    {$sort:{
        'quantity': -1
    }}
])

//Cantidad de reseñas publicadas hacia un mismo tecnico

db.reseniasTecnicos.aggregate([
    {$group: {
        _id: '$tecnicoId',
        quantity: {$count: {}}
    }},
    {$sort:{
        'quantity': -1
    }}
])

//Consumidores por departamento

db.consumidores.aggregate([
    {$group:{
       _id: '$distrito.departamento',
       quantity: {$count:{}}
    }},
    {$sort:{
        'quantity': -1
    }}
])

//Correo electronico de los tecnicos con estado activo

db.detalleTecnicos.aggregate([
    {$match:{
        'estado': 'Activa'
    }},
    {$group:{
        _id: '$correo_electronico'
    }},
    {$sort:{
        'quantity': -1
    }}
])

//Cantidad de reseñas publicadas en un mismo año

db.reseniasTecnicos.aggregate([
    {$group:{
        _id: { $year: "$fecha"},
        quantity: {$count: {}}
    }},
    {$sort:{
        'quantity': -1
    }}
])


//Promedio de puntajes de reseñas por técnico
db.reseniasTecnicos.aggregate([
    { $group: { 
        _id: "$tecnicoId", 
        avgRating: { $avg: "$puntaje" } 
    } },
    { $sort: {
         avgRating: -1 
        } }
])

//Encontrar el número de técnicos por especialidad
db.tecnicos.aggregate([
    { $group: { 
        _id: "$especialidad", 
        count: { $sum: 1 } 
    } },
    { $sort: { 
        count: -1 
    } }
])

//Consumidores por distrito
db.consumidores.aggregate([
    { $group: { 
        _id: "$distrito.nombre_distrito", 
        count: { $sum: 1 } 
        } 
    },
    { $sort: { 
        count: -1 
    } }
])

//técnicos de género "Masculino"
db.tecnicos.distinct(
    "especialidad",
    { genero: "Masculino" })
// Consumidores por Departamento
db.consumidores.aggregate([
    {
        $group: {
            _id:"$distrito.departamento",
            count:{$sum: 1}
        } 
    },
    {
        $sort:{
            count:-1
        }
    }
])

// Cantidad de tecnicos por tipo de cuenta
db.detalleTecnicos.aggregate([
    {
        $group:{
            _id:"$estado",
            count: {$sum:1}
        }
    },
    {
        $sort:{
            count: -1 
        }

    }
        
])
