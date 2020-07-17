# APIREST para registro de propiedades con RubyOnRails

##### Descripción:

Esta es una aplicación backend que implementa methodos para el registro de propiedades.

##### Methodos de la aplicación:

###### Usuarios:

- **_POST_** => /login [Valida el login de acceso al portal]
- **_GET_** => /current [Obtiene información del usuario logueado, requiere un token].
- **_GET_** => /users [obtiene la lista de usuarios]
- **_POST_** => /users [Crea un usuario]
- **_GET_** => /users/:id [Obtiene informacion de un usuario en especifico]

###### Propiedades:

- **_GET_** => /property/addvisits/:id [Incrementa el Nro de visitas]
- **_POST_** => /property/sendemail/:id [Envia un email al propietario]
- **_GET_** => /propertiesforuser [Lista propiedades por usuario]
- **_GET_** => /properties [Lista todas las propiedades registradas]
- **_POST_** => /properties [Crea una Propiedad]
- **_DELETE_** => /properties/:id [Elimina una propiedad]

### Técnologia empleada

- [RubyOnRails]

## Pruebas realizadas con Postman

**Free Software**

[//]: #
[rubyonrails]: https://guides.rubyonrails.org/
