'use strict';

const Hapi = require('hapi');

const server = new Hapi.Server();
server.connection({ port: 3000, host: '0.0.0.0' });

//Initialize the mysql variable and create the connection object with necessary values
//Uses the https://www.npmjs.com/package/mysql package.
var mysql      = require('mysql');
var connection = mysql.createConnection({

    //host will be the name of the service from the docker-compose file. 
    host     : 'mysql',
    user     : 'adam',
    password : 'ashcraft',
    database : 'foodapp'
});


server.route({
    method: 'GET',
    path: '/',
    handler: function (request, reply) {
        console.log('Server processing a / request');
        reply('Hello, World!');
    }
});

//A new route to test connectivity to MySQL
server.route({
    method: 'GET',
    path: '/getData',
    handler: function (request, reply) {
        console.log('Server processing a /getData request');

        //Creates the connection

        //Does a simple select, not from a table, but essentially just uses MySQL
        //to add 1 + 1.
        //function (error, results, fields){...} is a call-back function that the
        //MySQL lib uses to send info back such as if there was an error, and/or the
        //actual results.
        connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
            if (error)
                throw error;
            //Sends back to the client the value of 1 + 1
            reply ('The solution is ' + results[0].solution);

            //for exemplar purposes, stores the returned value in a variable to be
            //printed to log
            var solution = results[0].solution;
            console.log('The solution is: ', solution);
        });
        //close the connection to MySQL
    }
});

server.route({
    method: 'GET',
    path: '/getusername',
    handler: function (request, reply) {
        console.log('Server processing a /getusername request');
	    connection.query('SELECT * FROM foodapp.account', function(error, result, fields) {
			if (error)
				throw error;
			reply ('User account Name is ' + result[0].uName);
			var solution = result;
			console.log('The return is ', solution);
		});
    }
});

server.route({
	method: 'GET',
	path: '/food',
	handler: function(request, reply) {
		console.log('Server processing a /food request');
		connection.query('SELECT * FROM foodapp.food', function(error, result, fields) {
			if (error)
				throw error;
			var str = '';
			var header = "The results are ordered by Name, Type, Group, Amount Remaining, Amount Sold, and Cost\n";
			str = str + header;
			var iLength = result.length;
			console.log(obj)
			for (var i = 0; i < iLength; i++) {
				var obj = result[i];
				console.log("Obj: " + JSON.stringify(obj, null, 4));
				var strTemp = ('Name: ' + obj.foodName + ', Type: ' + obj.foodType + ', Group: ' + obj.foodGroup + ', Amount: ' + obj.foodAmount + ', Sold: ' + obj.amountSold + ', Cost: ' + obj.foodCost + '\n');
				str = str + strTemp;
				var solution = result[i];
				console.log('Solution: ' + solution);
				console.log('Str: ' + str);
			}
			reply(str);
		});
	}
});

server.route({
	method: 'POST',
	path: '/user',
	handler: function(request, reply) {
		connection.query('INSERT INTO foodapp.account(fName, lName, uName, password) VALUES (' + request.payload['fName'] + ', ' + request.payload['lName'] + ', ' + request.payload['uName'] + ', ' + request.payload['password'] + ';');
		reply ('User Added: ' + request.payload['lName'] + ', ' + request.payload['fName'] + ' as ' + request.payload['uName'] + ' with password "' + request.payload['password'] + '"');
	}
});

server.route({
	method: 'GET',
	path: '/user/{name}',
	handler: function(request, reply) {
		reply ('Showing account details for ' + encodeURIComponent(request.params.name) + '.');
	}
});

server.route({
	method: 'GET',
	path: '/restaurants/{name}',
	handler: function (request, reply) {
		//Get the restaurants that are owned by {name}
		console.log('Server processing /restaurants/{name} request');
		reply('Displaying restaurants owned by ' + encodeURIComponent(request.params.name) + '!');
	}
});

server.route({
	method: 'GET',
	path: '/restaurants',
	handler: function (request, reply) {
		//Get a list of all restaurants
		console.log('Server processing /restaurants request');
		reply('Displaying a list of all restaurants!');
	}
});


server.start((err) => {

    if (err) {
        throw err;
    }
    console.log(`Server running at: ${server.info.uri}`);
});