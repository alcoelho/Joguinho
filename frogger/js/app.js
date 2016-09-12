// Enemies our player must avoid
var Enemy = function() {
    // Variables applied to each of our instances go here,
    // we've provided one for you to get started

    // The image/sprite for our enemies, this uses
    // a helper we've provided to easily load images
	this.reset();
    this.sprite = 'images/enemy-bug.png';
};

// Update the enemy's position, required method for game
// Parameter: dt, a time delta between ticks
Enemy.prototype.update = function(dt) {
    // You should multiply any movement by the dt parameter
    // which will ensure the game runs at the same speed for
    // all computers.
	//console.log(this.x, this.y)
	this.row = this.walk(this.x);
	if(this.x !== 0 && this.y !==0){
		this.x +=  (dt * this.speed);
		this.y +=  dt;
	}
	else if(this.x ===0 ){
		this.x = 1;
		if( this.col === 2 ){
			this.speed = this.speed * getRandomInt(1,2);
		}
		else if( this.col === 3){
			this.speed = this.speed * getRandomInt(2,3);
		}
		else{
			this.speed = this.speed * getRandomInt(1,4);
		}
	}
	
	
	if(this.x > 5 * 101 ){
		this.reset();
	}
};

Enemy.prototype.walk = function(x){
	if(x<101){
		return 1;
	}
	else if(x<202){
		return 2;
	}
	else if(x<303){
		return 3;
	}
	else if(x<404){
		return 4;
	}
	else if(x<505){
		return 5;
	}
	else{
		return 0;
	}
}


// Draw the enemy on the screen, required method for game
Enemy.prototype.render = function() {
    ctx.drawImage(Resources.get(this.sprite), this.x, this.y);
};

Enemy.prototype.reset = function(){
	this.col = getRandomInt(1,5);
	this.row = 0;
	this.x = this.row * 101; //Eixo x
	this.y = this.col * 83;  //Eixo y
	this.speed = 100;
	
}

// Now write your own player class
// This class requires an update(), render() and
// a handleInput() method.
var Player = function(){
	this.reset();
	this.sprite = 'images/chargirl.png';
	
}

Player.prototype.render = function(){
	ctx.drawImage(Resources.get(this.sprite), this.x, this.y);
}

Player.prototype.reset = function(){
	this.col = 6;
	this.row = getRandomInt(0,4);
	this.movable = true;
}

Player.prototype.update = function(dt){
	//console.log(this.x, this.y);
	if(this.movable){
		this.x = 101 * this.row;  //Eixo x
		this.y = 83 * this.col;   //Eixo y
	}
	if(this.y < 0 && this.movable){
		this.movable = false;
		if(this.y === 0){
			this.reset();
		}
		return true;
	}
	if(this.y === 0){
		this.reset();
	}
	return false;
	
};

Player.prototype.handleInput = function(key){
	switch(key){
		case 'left':
			this.col--;
			break;

		case 'up':
			this.row--;
			break;

		case 'right':
			this.col++;
			break;
		
		case 'down':
			this.row++;
			break;
	}
	if(this.col<0){ this.col = 0;}
	if(this.col>6){ this.col = 6;}
	if(this.row<0){ this.row = 0;}
	if(this.row>4){ this.row = 4;}
	
}

function getRandomInt(min, max){
	return Math.floor(Math.random()* (max - min + 1)) + min;
}

var allEnemies = [];
for(var i=0; i<4; i++){
	allEnemies.push(new Enemy());
}

var player = new Player();


// Now instantiate your objects.
// Place all enemy objects in an array called allEnemies
// Place the player object in a variable called player



// This listens for key presses and sends the keys to your
// Player.handleInput() method. You don't need to modify this.
document.addEventListener('keyup', function(e) {
    var allowedKeys = {
        37: 'up',
        38: 'left',
        39: 'down',
        40: 'right'
    };

    player.handleInput(allowedKeys[e.keyCode]);
});
