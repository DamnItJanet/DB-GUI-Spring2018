'use strict';
const bcrypt = require('bcrypt-nodejs');
const Hapi = require('hapi');

const server = new Hapi.Server();
server.connection({ port: 3000, host: '0.0.0.0' });

//Initialize the mysql variable and create the connection object with necessary values
//Uses the https://www.npmjs.com/package/mysql package.
var mysql      = require('mysql');
var connection = mysql.createConnection({

    //host will be the name of the service from the docker-compose file. 
    host     : 'mysql',
    user     : 'casey',
    password : 'password',
    database : 'foodapp'
});


server.route({
    method: 'GET',
    path: '/',
    handler: function (request, reply) {
        console.log('Server processing a / request');
        var varia = {
            response: "Hello World"
        };
        reply(varia);
    }
});

////////////Account Stuff///////////////

//login
server.route({
	method: 'POST',
	path: '/login',
	handler: function(request, reply) {
        var user = request.payload['username'];
        var pass = request.payload['password']; 
        var sql = "SELECT * FROM account WHERE username = ?";
        connection.query(sql, user, function(error, results, fields) {
            if (error)
                throw error;
            else{
                if(results.length >0){
                    bcrypt.compare(pass, results[0].password, function(err, ress) {
                        if(!ress){
                            reply({'reply': 'Username and password do not match'});
                        }else{
                            reply(results[0]);
                        }
                    });
                }
                else{
                    reply({'reply': 'Username does not exist'});
                }
                
            }
            
        });

	}
});

//Add a new user to database
server.route({
	method: 'POST',
	path: '/newuser',
	handler: function(request, reply) {
        
        var salt = bcrypt.genSaltSync(10);
        var hash = bcrypt.hashSync(request.payload['password'], salt);

        var value = {
            "fName": request.payload['fName'],
            "lName": request.payload['lName'],
            "username": request.payload['username'],
            "password": hash

        }
        var sql = 'INSERT INTO account SET ?';

		connection.query(sql, value, function(err, result) {
            if(err) {
                throw err;
            } 
            reply ('User Added: ' + request.payload['fName'] + ', ' + request.payload['lName'] + ' as ' + request.payload['username'] + ' with password "' + request.payload['password'] + '"');
        });
		
	}
});

/////////////////////////////////////////////////






//A new route to test connectivity to MySQL
server.route({
    method: 'GET',
    path: '/getData',
    handler: function (request, reply) {
        console.log('Server processing a /getData request');

        connection.query('SELECT * FROM account', function (error, result, fields) {
            if (error)
                throw error;
            //Sends back to the client the value of 1 + 1
            reply ('User account Name is: ' + result[0].fName);

            //for exemplar purposes, stores the returned value in a variable to be
            //printed to log
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});

//get a user
server.route({
	method: 'GET',
	path: '/user/{username}',
	handler: function(request, reply) {
        var name = request.params.username;

        var sql = "SELECT * FROM account WHERE username = ?";
        var userStuff;
        connection.query(sql, name, function(error, result, fields) {
            if (error)
                throw error;
            userStuff = result[0];
            console.log(userStuff);
            reply (userStuff);
        });

	}
});

//get a restaurant
server.route({
	method: 'GET',
	path: '/restaurant/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT * FROM restaurant WHERE idrestaurant = ?";
        var userStuff;
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
            userStuff = result[0];
            console.log(userStuff);
            reply (result);
        });

	}
});

//get a restaurant
server.route({
	method: 'GET',
	path: '/OwnerRest/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT * FROM restaurant WHERE ownerId = ?";
        var userStuff;
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
            userStuff = result[0];
            console.log(userStuff);
            reply (result);
        });

	}
});

// return all food
server.route({
    method: 'GET',
    path: '/getFood',
    handler: function (request, reply) {
        console.log('Server processing a /getFood request');

        connection.query('SELECT * FROM food', function (error, result, fields) {
            if (error)
                throw error;
            
            
            reply (result);
            
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});

// return menu for specifc restuarant
server.route({
    method: 'GET',
    path: '/getFood/{id}',
    handler: function (request, reply) {
        console.log('Server processing a /getFood request');
        var id = request.params.id;

        connection.query('SELECT * FROM food WHERE menuId ='+id, function (error, result, fields) {
            if (error)
                throw error;
            // var output = [];
            // for (var x = 0; x < result.length; x++ ) {
            //      output.push(result[x]);
            // };
            
            reply (result);
            
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});

// return all restaurants
server.route({
    method: 'GET',
    path: '/getRest',
    handler: function (request, reply) {
        console.log('Server processing a /getRest request');

        connection.query('SELECT * FROM restaurant', function (error, result, fields) {
            if (error)
                throw error;
            var output = [];
            for (var x = 0; x < result.length; x++ ) {
                 output.push(result[x]);
            };
            
            reply (result);
            
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});


// return all ingredients for a specific restuarant
server.route({
    method: 'GET',
    path: '/getING/{id}',
    handler: function (request, reply) {
        console.log('Server processing a /getING request');
        var id = request.params.id;

        connection.query('SELECT * FROM ingredients WHERE restID ='+id, function (error, result, fields) {
            if (error)
                throw error;
            var output = [];
            for (var x = 0; x < result.length; x++ ) {
                 output.push(result[x]);
            };
            
            reply (result);
            
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});


server.route({
    method: 'POST',
    path: '/user',
    handler: function (request, reply) {
        reply('User Added: ' + request.payload['lName'] + ', ' + request.payload['fName']);
    }
});



//add a new restaurant
server.route({
	method: 'POST',
	path: '/newRest',
	handler: function(request, reply) {
        //var sql = 'INSERT INTO foodapp.restaurant(restName, restLocation, ownerId) VALUES (?)'; 
        //var value = [[request.payload['restName'], request.payload['restLocation'], request.payload['ownerId']]];

        var val = {
            'restName': request.payload['restName'],
            'restLocation': request.payload['restLocation'],
            'ownerId': request.payload['ownerId'],
            'restLink': request.payload['restLink'],
            'restNews': request.payload['restNews'],
            'restIMGLink': request.payload['restIMGLink'],
            'restType': request.payload['restType'],
            'zipCode': request.payload['zipCode'],
            'city': request.payload['city']
        };
        var sql = 'INSERT INTO restaurant SET ?';

		connection.query(sql, val, function(err, result) {
            if(err) {
                throw err;
            } 
            reply ('Restaurant Added: ' + request.payload['restName'] + ', located at ' + request.payload['restLocation'] + ' and owned by ' + request.payload['ownerId'] );
        });
		
	}
});




//Add a new food to database
server.route({
	method: 'POST',
	path: '/newFood',
	handler: function(request, reply) {
    
        var val = {
            'foodName': request.payload['foodName'],
            'foodType': request.payload['foodType'],
            'foodSold': request.payload['foodSold'],
            'foodCost': request.payload['foodCost'],
            'menuId': request.payload['menuId'],
            'rating': request.payload['rating'],
            'foodING': request.payload['foodING']
        };

        var sql = 'INSERT INTO food SET ?';

		connection.query(sql, val, function(err, result) {
            if(err) {
                throw err;
            } 
            reply ('Food Added: ' + request.payload['foodName']);
        });
		
	}
});

//Add a new food to database
server.route({
	method: 'PUT',
	path: '/updateFood/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = 'UPDATE food SET ? WHERE idfood = '+id; 
        //var value = [[request.payload['foodSold'], request.payload['rating'], request.payload['foodCost']]];
        var value = {
            'foodSold': request.payload['foodSold'], 
            'rating': request.payload['rating'], 
            'foodCost': request.payload['foodCost']
        }

		connection.query(sql, value, function(err, result) {
            if(err) {
                throw err;
            } 
            
        });

        connection.query('SELECT foodName, foodSold FROM food WHERE idfood = '+id, function(err, result) {
            if(err) {
                throw err;
            } 
            reply("Food updated: " +result[0].foodName+ ". Sold: "+result[0].foodSold);
        });
		
	}
});

//get owners
server.route({
	method: 'GET',
	path: '/owners',
	handler: function(request, reply) {
        var sql = "SELECT fName FROM account NATURAL JOIN restaurant WHERE idaccount = ownerId GROUP BY fName";
        var userStuff;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            
            reply (result);
        });

	}
});

//delete a restaurant
server.route({
	method: 'DELETE',
	path: '/deleteRest/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "DELETE FROM restaurant WHERE idrestaurant = "+id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            
            reply ('Restaurant Deleted');
        });

	}
});


//delete a food
server.route({
	method: 'DELETE',
	path: '/deleteFood/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "DELETE FROM food WHERE idfood = "+id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            
            reply ('Food Deleted');
        });

	}
});




//serves the server
server.start((err) => {

    if (err) {
        throw err;
    }
    console.log(`Server running at: ${server.info.uri}`);
});
