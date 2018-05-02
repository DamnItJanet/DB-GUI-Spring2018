'use strict';
const bcrypt = require('bcrypt-nodejs');
const Hapi = require('hapi');

const server = new Hapi.Server();
server.connection({ 
		port: 3000, 
		host: '0.0.0.0', 
		routes: {
            cors: true
        } 
	});

//Initialize the mysql variable and create the connection object with necessary values
//Uses the https://www.npmjs.com/package/mysql package.
var mysql      = require('mysql');
var connection = mysql.createConnection({

    //host will be the name of the service from the docker-compose file. 
    host     : 'backenddb.c9zxxl8lk1zb.us-east-1.rds.amazonaws.com',
    //host     : 'localhost',
    user     : 'backend',
    password : 'FarkMontenot',
    database : 'dbgui_5'
    //socketPath: '/var/run/mysqld/mysqld.sock'
});


server.route({
    method: 'GET',
    path: '/',
    handler: function (request, reply) {
        console.log('Server processing a / request');
        reply('Hello, world!');
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
        var sql = "SELECT idAccount as id, fName as firstName, lName as lastName, username, password, email, type  FROM account WHERE status=1 and username = ?";
        connection.query(sql, user, function(error, results, fields) {
            if (error)
                throw error;
            else{
                if(results.length >0){
                    bcrypt.compare(pass, results[0].password, function(err, ress) {
                        if(!ress){
							reply({"result": 0, "message": "Email and password does not match"});
                        }else{
							reply({"result": 1, "user": results[0], "message": " "});
						}
                    });
                }
                else{
					//console.log('cannot find user:' + user);
                    reply({"result": 0, "message": "Cannot find this user"});
                }
            }
            
        });

	}
});



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

/////////////////////////////////////////////////
// User services
/////////////////////////////////////////////////

//Add a new user to database
server.route({
	method: 'POST',
	path: '/user',
	handler: function(request, reply) {
        //Check for 
		connection.query('select * from account where username = ?', request.payload['username'], function(err, result) {
			if (err){
				//isError = true;
                throw err;
			} else {
                if(result.length >0){
					reply({"result": 0, "message": "Username is already existed"});
					return;
				}
				else {
					var salt = bcrypt.genSaltSync(10);
					var hash = bcrypt.hashSync(request.payload['password'], salt);

					var value = {
						"fName": request.payload['firstName'],
						"lName": request.payload['lastName'],
						"username": request.payload['username'],
						"password": hash,
						"email": request.payload['email'],
						"type": request.payload['type'],
						"status": 1
					}
					var sql = 'INSERT INTO account SET ?';

					connection.query(sql, value, function(err, result) {
						if(err) {
							console.log('error increating new user');
							throw err;
						}
						else {
							reply({"result": 1, "message": "User was created successfully"});
						}
					});
				}
			}
		});
	}
});

// Get users list
server.route({
    method: 'GET',
    path: '/user',
    handler: function (request, reply) {
		connection.query('SELECT idAccount as id, fName as firstName, lName as lastName, username, email, type FROM `account` where status=1',
		function (error, results, fields) {
		if (error) 
			throw error;
		else
			reply(results);
	   
    });
  }
});

//get a user by username
server.route({
	method: 'GET',
	path: '/user/by-username/{username}',
	handler: function(request, reply) {
        var name = request.params.username;

        var sql = "SELECT idAccount as id, fName as firstName, lName as lastName, username, email, type FROM account WHERE username = ?";
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

//get a user by id
server.route({
	method: 'GET',
	path: '/user/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT idAccount as id, fName as firstName, lName as lastName, username, email, type FROM account WHERE idAccount = ?";
        var userStuff;
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
            userStuff = result[0];
            reply (userStuff);
        });

	}
});

//update user info to database
server.route({
	method: 'PUT',
	path: '/user/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
		///TODO: update user info here
		
		//Check for existence
		connection.query('select * from account where idAccount = ?', id, function(err, result) {
			if (err){
                throw err;
			} else {
                if(result.length <= 0){
					reply({"result": 0, "message": "User does not exist"});
					return;
				}
				else {
					var hash = result[0].password;
					if(request.payload['password'] != null && request.payload['password'] != undefined 
						&& request.payload['password'] != ''){
						var salt = bcrypt.genSaltSync(10);
						hash = bcrypt.hashSync(request.payload['password'], salt);						
					}
					
					var value = [
						request.payload['firstName'],
						request.payload['lastName'],
						//"username": request.payload['username'],
						hash,
						request.payload['email'],
						request.payload['type'],
					];
					
					var sql = 'Update account SET fName=?, lName=?, password=?, email=?, type=? where idAccount=' + id;

					connection.query(sql, value, function(err, result) {
						if(err) {
							console.log('Cannot update user info');
							throw err;
						}
						else {
							reply({"result": 1, "message": "User was updated successfully"});
						}
					});
				}
			}
		});
		
	}
});

//delete a user
server.route({
	method: 'DELETE',
	path: '/user/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "UPDATE account SET status=0 WHERE idaccount =" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            else {
				reply({"result": 1, "message": "User was successfully deleted"});
			}
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
            var output = [];
            for (var x = 0; x < result.length; x++ ) {
                    output.push(result[x].fName);
            };
            
            reply ('Owners are: ' + output);
        });

	}
});



/////////////////////////////////////////////////
// menu services
/////////////////////////////////////////////////

//Add a new menu to database
server.route({
	method: 'POST',
	path: '/menu',
	handler: function(request, reply) {

		var value = {
			"restaurantId": request.payload['restaurantId'],
			"name": request.payload['name'],
			//"username": request.payload['username'],
			"description": request.payload['description'],
			"imageName": request.payload['imageName'],
			"rate": 0,
			"status": 1,
		}
		var sql = 'INSERT INTO menu SET ?';

		connection.query(sql, value, function(err, result) {
			if(err) {
				console.log('error increating new menu');
				throw err;
			}
			else {
				reply({"result": 1, "message": "Menu was created successfully"});
			}
		});

	}
});

// Get menu list by restaurant
server.route({
    method: 'GET',
    path: '/menu/restaurant/{id}',
    handler: function (request, reply) {
		var id = request.params.id;
		
		connection.query('SELECT * FROM `menu` where status=1 and restaurantId=?', id, function (error, results, fields) {
		if (error) 
			throw error;
		else
			reply(results);
	   
    });
  }
});

//get a menu by id
server.route({
	method: 'GET',
	path: '/menu/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT * FROM menu WHERE id = ?";
        var menuStuff;
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
            menuStuff = result[0];
            reply (menuStuff);
        });

	}
});

//delete a menu
server.route({
	method: 'DELETE',
	path: '/menu/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "UPDATE menu SET status=0 WHERE id=" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            else {
				reply({"result": 1, "message": "The menu was successfully deleted"});
			}
        });

	}
});




/////////////////////////////////////////////////
// reiview services
/////////////////////////////////////////////////

//Add a new review to database
server.route({
	method: 'POST',
	path: '/review',
	handler: function(request, reply) {

		var value = {
			"reviewOf": request.payload['reviewOf'],
			"username": request.payload['userName'],
			"rating": request.payload['rating'],
			"comment": (request.payload['comment'] === undefined ? '' : request.payload['comment']),
			//"date": request.payload['date'].slice(0, 19).replace('T', ' '),
			"type": request.payload['type'],
			"status": 1,
		}
		var sql = 'INSERT INTO review SET ?';
		
		connection.query(sql, value, function(err, result) {
			if(err) {
				console.log('error in saving new review');
				throw err;
			}
			else {
				//check and update menu review
				if(request.payload['type'] === 2) {
					sql = 'select ifNull(sum(rating), 0) as sum,  ifNull(count(*),0) as count from review where type = 2 and ReviewOf =?';
					connection.query(sql, request.payload['reviewOf'], function(err, res){
						let sum = res[0].sum + request.payload['rating'];
						let count = res[0].count + 1;
						connection.query('update menu set rate=(? + 0.0)/? where id=?', [sum, count, request.payload['reviewOf']], function(error, res){
							if(error){
								throw err;
							}
							//console.log(res);
						});
					});
				}
				reply({"result": 1, "message": "Review was submit successfully"});
			}
		});
		
		//update menu rating

	}
});

// Get review list by restaurant
// note: review type = 1: review of restaurant, type = 2: review of menu
server.route({
    method: 'GET',
    path: '/review/restaurant/{id}',
    handler: function (request, reply) {
		var id = request.params.id;
		
		connection.query('SELECT * FROM `review` where status=1 and type=1 and reviewOf=?', id, function (error, results, fields) {
		if (error) 
			throw error;
		else
			reply(results);
	   
    });
  }
});

// Get review list by menu (of a restaurant)
// note: review type = 1: review of restaurant, type = 2: review of menu
server.route({
    method: 'GET',
    path: '/review/menu/{id}',
    handler: function (request, reply) {
		var id = request.params.id;
		
		connection.query('SELECT * FROM `review` where status=1 and type=2 and reviewOf=?', id, function (error, results, fields) {
		if (error) 
			throw error;
		else
			reply(results);
	   
    });
  }
});

//get a review by id
server.route({
	method: 'GET',
	path: '/review/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT * FROM review WHERE id = ?";
        var reviewStuff;
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
            reviewStuff = result[0];
            reply (reviewStuff);
        });

	}
});

//delete a review
server.route({
	method: 'DELETE',
	path: '/review/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "UPDATE review SET status=0 WHERE id=" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            else {
				reply({"result": 1, "message": "The review was successfully deleted"});
			}
        });

	}
});


////////////////////////////////////////////////
// Restaurant services
/////////////////////////////////////////////////

//get all restaurants
server.route({
	method: 'GET',
	path: '/restaurant',
	handler: function(request, reply) {
        connection.query('select idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName, description, zipcode  from `restaurant` WHERE 1', function (error, results, fields) {
			if (error) 
				throw error;
			else {
				//var test2 = new Buffer( results[1].imageName, 'binary' ).toString();
				reply(results);
			}
		});
	}
});


//get all restaurants
server.route({
	method: 'GET',
	path: '/restaurant/by-guest/{id}',
	handler: function(request, reply) {
		var id = request.params.id;
		var sql = 'select idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName,' 
				+ ' description, zipcode, case when flw.restID is null then 0 else 1 end isFollowing ' 
				+ ' from restaurant res left outer join userfollows flw on res.idrestaurant = flw.restID and flw.userID = ' + id;
				
        connection.query(sql, function (error, results, fields) {
			if (error) 
				throw error;
			else {
				//var test2 = new Buffer( results[1].imageName, 'binary' ).toString();
				reply(results);
			}
		});
	}
});


//search for restaurants
server.route({
	method: 'POST',
	path: '/restaurant/search/{term}',
	handler: function(request, reply) {
		var term = "%" + request.params.term + "%";
		var id = request.payload['userId'];
		
		var sql = 'select idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName,' 
				+ " description, zipcode, case when flw.restID is null then 0 else 1 end isFollowing " 
				+ " from restaurant res left outer join userfollows flw on res.idrestaurant = flw.restID and flw.userID =?"
				+ " where res.restName like ? or res.zipcode like ? or res.city like ?";
				
		// var sql = 'select idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName,' 
				// + " description, zipcode, case when flw.restID is null then 0 else 1 end isFollowing " 
				// + " from restaurant res left outer join userfollows flw on res.idrestaurant = flw.restID and flw.userID =" + id
				// + " where res.restName like '%" + term + "%' or res.zipcode like '%" + term + "%' or res.city like '%" + term + "%'";
		// console.log(sql);
		var value = [
			id,
			term,
			term,
			term,
		];	
        connection.query(sql, value, function (error, results, fields) {
			if (error) 
				throw error;
			else {
				//var test2 = new Buffer( results[1].imageName, 'binary' ).toString();
				reply(results);
			}
		});
	}
});

//get a restaurant
server.route({
	method: 'GET',
	path: '/restaurant/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName, description, zipcode FROM restaurant WHERE idrestaurant = ?";
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
			else {
				reply (result[0]);
			}
        });

	}
});

//get a restaurant by owner id
server.route({
	method: 'GET',
	path: '/restaurant/by-owner/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "SELECT idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName, description, zipcode FROM restaurant WHERE ownerId =" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
			else {
				if(result.length > 0) {
					reply (result[0]);
				}
				else {
					console.log('cannot find');
					reply ({});
				}
			}
        });

	}
});


///TODO: re test this
//Add a new restaurant to database with userID and restaurant object passed in
server.route({
        method: 'POST',
        path: '/restaurant',
        handler: function(request, reply) {
                var value = {
                        "restName": request.payload['name'],
                        "restLocation": request.payload['address'],
                        "ownerId": request.payload['ownerId'],
                        "restLink": request.payload['link'],
                        //"restNews": request.payload['news'],
                        "restIMGLink": request.payload['imageName'],
                        //"restType": request.payload['restType'],
                        "zipCode" : request.payload['zipcode'],
                        "city": request.payload['city'],
                        "description": request.payload['description']
                }

                var sql = 'INSERT INTO restaurant SET ?';

                connection.query(sql, value, function(err, result) {
                        if(err) {
                                throw err;
                        }
                        // console.log('Restaurant successfully added');
                        // reply(result);
						reply({"result": result.affectedRows,  "id": result.insertId, "message": "restaurant was created successfully"});
                });
        }
});


// return all food
server.route({
    method: 'GET',
    path: '/foods',
    handler: function (request, reply) {
        console.log('Server processing a /getData request');

        connection.query('SELECT * FROM food', function (error, result, fields) {
            if (error)
                throw error;
            var output = [];
            for (var x = 0; x < result.length; x++ ) {
                 output.push(result[x].foodName);
            };
            
            reply ('User foods are: ' + output);
            
            var solution = result;
            console.log('The solution is: ', solution);
        });
       
    }
});

//update restaurant
server.route({
	method: 'PUT',
	path: '/restaurant/{id}',
	handler: function(request, reply) {
		console.log('enter restaurant update');
		var id = request.params.id;
		var sql = 'Update restaurant set restName=?, restLocation=?, restLink=?, restIMGLink=?, zipcode=?, city=?, description=? ' 
			+ ' where idrestaurant=' + id;
		
		var value = [
						request.payload['name'],
						request.payload['address'],
						request.payload['link'],
						request.payload['imageName'],
						request.payload['zipcode'],
						request.payload['city'],
						request.payload['description'],						
					];
					
		connection.query(sql, value, function(err, result) {
			if(err) {
				console.log('error in updating post');
				throw err;
			}
			else {
				reply({"result": 1, "message": "Post was updated successfully"});
			}
		});
		//update menu rating
	}
});


//delete a restaurant
server.route({
	method: 'DELETE',
	path: '/restaurant/{id}',
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


////////////////////////////////////////////////
// Restaurant-post services
/////////////////////////////////////////////////
//get all posts
server.route({
	method: 'GET',
	path: '/post',
	handler: function(request, reply) {
        connection.query( 'SELECT post.*, acc.username as author, rest.restName as restaurantName '
						+ 'FROM restaurantpost post join account acc on post.userId = acc.idaccount '
						+ '		join restaurant rest on post.restaurantId = rest.idrestaurant '
						+ 'WHERE post.status=1 order by post.createdDate desc', function (error, results, fields) {
			if (error) 
				throw error;
			else {
				reply(results);
			}
		});
	}
});

//get all restaurant posts of a restaurant
server.route({
	method: 'GET',
	path: '/post/restaurant/{restId}',
	handler: function(request, reply) {
		var restId = request.params.restId;
		var sql = 'SELECT post.*, acc.username as author, rest.restName as restaurantName '
						+ 'FROM restaurantpost post join account acc on post.userId = acc.idaccount '
						+ '		join restaurant rest on post.restaurantId = rest.idrestaurant '
						+ 'WHERE post.status=1 and post.restaurantId=? order by post.createdDate desc';

        connection.query(sql, restId, function (error, results, fields) {
			if (error) 
				throw error;
			else {
				reply(results);
			}
		});
	}
});

//insert a new restaurant-post to database
server.route({
	method: 'POST',
	path: '/post',
	handler: function(request, reply) {

		var value = {
			"content": request.payload['content'],
			"userId": request.payload['userId'],
			"restaurantId": request.payload['restaurantId'],
			"status": 1,
		}
		var sql = 'INSERT INTO restaurantpost SET ?';
		
		connection.query(sql, value, function(err, result) {
			if(err) {
				console.log('error in saving new post');
				throw err;
			}
			else {
				reply({"result": 1, "message": "Post was created successfully"});
			}
		});
		//update menu rating
	}
});

//update post
server.route({
	method: 'PUT',
	path: '/post/{id}',
	handler: function(request, reply) {
		var id = request.params.id;
		var sql = 'Update restaurantpost set content=? where id=' + id;
		
		connection.query(sql, request.payload['content'], function(err, result) {
			if(err) {
				console.log('error in updating post');
				throw err;
			}
			else {
				reply({"result": 1, "message": "Post was updated successfully"});
			}
		});
		//update menu rating
	}
});

//delete a restaurant post
server.route({
	method: 'DELETE',
	path: '/post/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "UPDATE restaurantpost SET status=0 WHERE id=" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
			
            console.log(result);
            reply({"result": 1, "message": "Post was deleted successfully"});
        });

	}
});

//get all restaurant posts that a user follow
server.route({
	method: 'GET',
	path: '/newsfeed/{userId}',
	handler: function(request, reply) {
		var userId = request.params.userId;
		var sql = 'SELECT post.*, acc.username as author, rest.restName as restaurantName '
						+ 'FROM restaurantpost post inner join account acc on post.userId = acc.idaccount '
						+ '		inner join restaurant rest on post.restaurantId = rest.idrestaurant '
						+ 'WHERE post.status=1 and post.restaurantId in (select restId from userfollows where userId=?) order by post.createdDate desc';

        connection.query(sql, userId , function (error, results, fields) {
			if (error) 
				throw error;
			else {
				reply(results);
			}
		});
	}
});

//////////////////////////////////////////////////
//inventory services
//////////////////////////////////////////////////
//get all inventories 
server.route({
	method: 'GET',
	path: '/inventory',
	handler: function(request, reply) {
		var sql = 'select * from inventory where 1'; 

        connection.query(sql, function (error, results, fields) {
			if (error) 
				throw error;
			else {
				reply(results);
			}
		});
	}
});

//get all inventories of a restaurant
server.route({
	method: 'GET',
	path: '/inventory/restaurant/{id}',
	handler: function(request, reply) {
		var id = request.params.id;
		var sql = 'select * from inventory where restaurantId =?'; 

        connection.query(sql, id, function (error, results, fields) {
			if (error) 
				throw error;
			else {
				reply(results);
			}
		});
	}
});

//insert a new restaurant-post to database
server.route({
	method: 'POST',
	path: '/inventory',
	handler: function(request, reply) {
		var value = {
			"productName": request.payload['productName'],
			"importDate": request.payload['importDate'],
			"expirationDate": request.payload['expirationDate'],
			"total": request.payload['total'],
			"status": request.payload['status'],
			"description": request.payload['description'],
			"restaurantId": request.payload['restaurantId'],
		}
		var sql = 'INSERT INTO inventory SET ?';
		
		connection.query(sql, value, function(err, result) {
			if(err) {
				throw err;
			}
			else {
				reply({"result": 1, "message": "Inventory was created successfully"});
			}
		});
		//update menu rating
	}
});


//update restaurant
server.route({
	method: 'PUT',
	path: '/inventory/{id}',
	handler: function(request, reply) {
		console.log('enter inventorry update');
		var id = request.params.id;
		var sql = 'Update inventory set productName=?, importDate=?, expirationDate=?, total=?, status=?, description=?, restaurantId=? ' 
			+ ' where id=' + id;

		var value = [
						request.payload['productName'],
						request.payload['importDate'],
						request.payload['expirationDate'],
						request.payload['total'],
						request.payload['status'],
						request.payload['description'],						
						request.payload['restaurantId'],
					];
					
		connection.query(sql, value, function(err, result) {
			if(err) {
				console.log('error in updating inventory');
				throw err;
			}
			else {
				reply({"result": 1, "message": "Inventory was updated successfully"});
			}
		});
	}
});


//get an inventory product
server.route({
	method: 'GET',
	path: '/inventory/{id}',
	handler: function(request, reply) {
        var id = request.params.id;

        var sql = "SELECT * FROM inventory WHERE id = ?";
        connection.query(sql, id, function(error, result, fields) {
            if (error)
                throw error;
			else {
				reply (result[0]);
			}
        });

	}
});


//delete a product
server.route({
	method: 'DELETE',
	path: '/inventory/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = "DELETE FROM inventory WHERE id=" + id;
        connection.query(sql, function(error, result, fields) {
            if (error)
                throw error;
            else {
				reply({"result": 1, "message": "Product was successfully deleted"});
			}
        });

	}
});


///////////////////////////////////////////////////////////////////
// following services
/////////////////////////////////////////////////

//Get followed restaurants of an Id
server.route({
	method: 'GET',
	path: '/following/{userId}',
	handler: function(request, reply) {
			var id = request.params.userId;
			var sql = "SELECT idrestaurant as id, `restName` as name, `restLocation` as address, `ownerId`, `restLink` as link, `restNews` as news, `restIMGLink` as imageName, description, zipcode  "
					+ " FROM restaurant WHERE idrestaurant in (select userId from userfollows WHERE userID = ?)";
			connection.query(sql, id, function(error, result, fields) {
					if (error)
							throw error;
					reply(result);
			});
	}
});

//set a user to follow a restaurant
server.route({
	method: 'POST',
	path: '/follow',
	handler: function(request, reply) {
			var userId = request.payload['userId'];
			var restId = request.payload['restaurantId'];

			var sql = "INSERT INTO userfollows VALUES (" + userId + ", " + restId + ")";
			connection.query(sql, function(error, result, fields) {
					if (error)
						throw error;
					//reply(result);
					reply({"result": 1, "message": "Following was set successfully"});
			});
	}
});


//set a user to unfollow a restaurant
server.route({
	method: 'POST',
	path: '/unfollow',
	handler: function(request, reply) {
		var userID = request.payload['userId'];
		var restID = request.payload['restaurantId'];
		var sql = "DELETE FROM userfollows WHERE userID = " + userID + " AND restID = " + restID;
		
		connection.query(sql, function(error, result, fields) {
			if (error)
					throw error;
			reply(result);
		});
	}
});

//is following
server.route({
	method: 'POST',
	path: '/is-following',
	handler: function(request, reply) {
		var userID = request.payload['userId'];
		var restID = request.payload['restaurantId'];
		var sql = "SELECT  * FROM userfollows WHERE userID = " + userID + " AND restID = " + restID;
		connection.query(sql, function(error, result, fields) {
			if (error)
					throw error;
			else {
				var res = (result.length > 0 ? 1 : 0)
				reply({"result": res, "message": " "});
			}
		});
	}
});


///////////////////////////////////////////////////////////////////
// food services
/////////////////////////////////////////////////

//Add a new food to database
server.route({
	method: 'POST',
	path: '/food',
	handler: function(request, reply) {
        var sql = 'INSERT INTO food(foodName, foodType, foodGroup, foodAmount, foodSold, foodCost) VALUES (?)'; 
        var value = [[request.payload['foodName'], request.payload['foodType'], request.payload['foodGroup'], request.payload['foodAmount'], request.payload['foodSold'], request.payload['foodCost']]];

		connection.query(sql, value, function(err, result) {
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
	path: '/food/{id}',
	handler: function(request, reply) {
        var id = request.params.id;
        var sql = 'UPDATE food SET foodSold = foodSold + ? WHERE idfood = '+id; 
        var value = [[request.payload['foodSold']]];

		connection.query(sql, value, function(err, result) {
            if(err) {
                throw err;
            } 
            
        });

        connection.query('SELECT foodName, foodSold, foodAmount FROM food WHERE idfood = '+id, function(err, result) {
            if(err) {
                throw err;
            } 
            reply("Food updated: " +result[0].foodName+ ". Sold: "+result[0].foodSold+ " with " +result[0].foodAmount+ " remaining");
        });
		
	}
});

//delete a food
server.route({
	method: 'DELETE',
	path: '/food/{id}',
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

///////////////////////////////////////////////////////////////////
//serves the server
server.start((err) => {

    if (err) {
        throw err;
    }
    console.log(`Server running at: ${server.info.uri}`);
});