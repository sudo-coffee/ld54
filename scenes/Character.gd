class_name Character extends Node2D

var color: Color
var haircolor: Color
var firstname: String
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var is_player: bool = false
var direction
var moving: bool = false

# Sourced from https://www.ssa.gov/oact/babynames/decades/names1960s.html
var namepool: Array = ["Michael", "David", "John", "James", "Robert", "Mark", "William", "Richard", "Thomas", "Jeffrey", "Steven", "Joseph", "Timothy", "Kevin", "Scott", "Brian", "Charles", "Paul", "Daniel", "Christopher", "Kenneth", "Anthony", "Gregory", "Ronald", "Donald", "Gary", "Stephen", "Eric", "Edward", "Douglas", "Todd", "Patrick", "George", "Keith", "Larry", "Matthew", "Terry", "Andrew", "Dennis", "Randy", "Jerry", "Peter", "Frank", "Craig", "Raymond", "Jeffery", "Bruce", "Rodney", "Mike", "Roger", "Tony", "Ricky", "Steve", "Jeff", "Troy", "Alan", "Carl", "Danny", "Russell", "Chris", "Bryan", "Gerald", "Wayne", "Joe", "Randall", "Lawrence", "Dale", "Phillip", "Johnny", "Vincent", "Martin", "Bradley", "Billy", "Glenn", "Shawn", "Jonathan", "Jimmy", "Sean", "Curtis", "Barry", "Bobby", "Walter", "Jon", "Philip", "Samuel", "Jay", "Jason", "Dean", "Jose", "Tim", "Roy", "Willie", "Arthur", "Darryl", "Henry", "Darrell", "Allen", "Victor", "Harold", "Greg", "Albert", "Jack", "Darren", "Ronnie", "Ralph", "Joel", "Louis", "Jim", "Micheal", "Marc", "Frederick", "Eddie", "Lee", "Stanley", "Tommy", "Eugene", "Tom", "Tracy", "Howard", "Leonard", "Kurt", "Marvin", "Kelly", "Brent", "Ernest", "Dwayne", "Aaron", "Brett", "Rick", "Benjamin", "Bill", "Reginald", "Duane", "Juan", "Fred", "Melvin", "Adam", "Norman", "Dan", "Mitchell", "Harry", "Jesse", "Carlos", "Nicholas", "Jerome", "Kirk", "Ray", "Don", "Calvin", "Glen", "Brad", "Theodore", "Derrick", "Karl", "Edwin", "Earl", "Lance", "Francis", "Clifford", "Kent", "Derek", "Wesley", "Alfred", "Antonio", "Warren", "Andre", "Clarence", "Bernard", "Kyle", "Tyrone", "Manuel", "Chad", "Luis", "Gordon", "Dave", "Nathan", "Guy", "Kerry", "Daryl", "Leroy", "Lonnie", "Perry", "Erik", "Maurice", "Marcus", "Alvin", "Gilbert", "Vernon", "Alexander", "Stuart", "Rickey", "Shane", "Franklin", "Leon", "Gregg", "Bob", "Darin", "Leslie", "Herbert", "Gene", "Lisa", "Mary", "Susan", "Karen", "Kimberly", "Patricia", "Linda", "Donna", "Michelle", "Cynthia", "Sandra", "Deborah", "Tammy", "Pamela", "Lori", "Laura", "Elizabeth", "Julie", "Brenda", "Jennifer", "Barbara", "Angela", "Sharon", "Debra", "Teresa", "Nancy", "Christine", "Cheryl", "Denise", "Tina", "Kathleen", "Melissa", "Robin", "Amy", "Diane", "Dawn", "Carol", "Kathy", "Rebecca", "Theresa", "Kim", "Rhonda", "Stephanie", "Cindy", "Janet", "Wendy", "Maria", "Michele", "Jacqueline", "Debbie", "Margaret", "Paula", "Sherry", "Catherine", "Carolyn", "Laurie", "Sheila", "Ann", "Jill", "Connie", "Diana", "Terri", "Suzanne", "Andrea", "Beth", "Janice", "Valerie", "Renee", "Christina", "Gina", "Lynn", "Annette", "Cathy", "Katherine", "Judy", "Carla", "Wanda", "Anne", "Dana", "Joyce", "Regina", "Beverly", "Monica", "Bonnie", "Kathryn", "Anita", "Sarah", "Darlene", "Jane", "Sherri", "Martha", "Anna", "Colleen", "Vicki", "Tracey", "Judith", "Tamara", "Gloria", "Betty", "Stacey", "Penny", "Shirley", "Victoria", "Jean", "Peggy", "Melanie", "Joan", "Melinda", "Shelly", "Stacy", "Virginia", "Marie", "Maureen", "Ruth", "Julia", "Ellen", "Tonya", "Shannon", "Heidi", "Joanne", "Dorothy", "Rita", "Gail", "Heather", "Deanna", "Holly", "Rose", "Vickie", "Carrie", "Veronica", "Yvonne", "Becky", "Helen", "Sylvia", "Yolanda", "April", "Elaine", "Sheri", "Marilyn", "Alice", "Jodi", "Rachel", "Sheryl", "Jackie", "Phyllis", "Jamie", "Frances", "Crystal", "Joann", "Eileen", "Shelley", "Toni", "Charlene", "Kristin", "Sally", "Charlotte", "Kristine", "Jeanne", "Sara", "Tanya", "Belinda", "Carmen", "Sandy", "Evelyn", "Alicia", "Sonya", "Lorraine", "Jeanette", "Yvette", "Loretta", "Joy", "Sue", "Norma", "Roberta", "Vanessa", "Shari", "Jo", "Natalie", "Tammie", "Traci", "Gwendolyn", "Nicole", "Felicia", "Melody", "Tami", "Shelia", "Marcia", "Doris", "Kristen", "Audrey", "Karla", "Jody", "Glenda", "Patty", "Amanda", "Pam"]

func _ready():
    color = Color(rng.randf(), rng.randf(), rng.randf(), 1.0)
    color.v = rng.randf() / 2.0 + 0.5 # Keep value at 0.5 or higher.
    color.s = rng.randf() / 4.0 + 0.5
    haircolor.v = rng.randf() / 2.0 + 0.3
    haircolor.s = rng.randf() / 3.0 + 0.1
    firstname = namepool[rng.randi() % namepool.size()]
    $Shoulders/ShouldersSprite.modulate = color
    $Head/HeadSprite.modulate = haircolor
    
    # Random movement loop.
    while not is_player:
        await get_tree().create_timer(rng.randf() * 1.0).timeout
        if moving:
            direction = rng.randf()
            var direction = rng.randf() * deg_to_rad(360)
            $Shoulders.constant_force = Vector2(0.0, (rng.randf() - 0.5) * 2.0).rotated($Shoulders.rotation) * 1600000.0
            $Shoulders.constant_torque = (rng.randf() -0.5) * 2.0 * 4800000.0
