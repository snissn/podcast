class UserHelper {

  constructor(UserHelper) {
    this.contract = UserHelper;
	}


	// returns a sorted list of movies
	getSortedEpisodes(web3) {
		return new Promise((resolve, reject) => {
			const {contract} = this;
			contract.setProvider(web3.currentProvider)
			// Declaring this for later so we can chain functions on contract.
			let UserInstance
			// Get accounts.
			return web3.eth.getAccounts((error, accounts) => {
				return contract.deployed().then((instance) => {
					UserInstance = instance
					// Get the value from the contract to prove it worked.
      web3.eth.getCoinbase((error, coinbase) => {
        // Log errors, if any.
        if (error) {
          alert(error);
        }

					return UserInstance.getNumEpisodes({from: coinbase})
					.then((result) => {
						let numEpisodes = result.c[0];
						let episodes = [];
						 console.log('numEpisodes');
						 console.log(numEpisodes);
						return this.recursiveGetEpisode(episodes, 0, numEpisodes, UserInstance, web3, coinbase)
						.then((allMovies) => {
							// sort the movies
              resolve(allMovies);
              /*
							let sortedMovies = allMovies.sort(
								function(a,b){
									return ((a.name > b.name)?-1:((a.name < b.name)?1:0))
								});
							// resolve the initial promise with a sorted list of movies
							resolve(sortedMovies);
              */
						});
					})
				})

        })


			})
		})
  }


	// returns a recursive promise building a list of all movies
	recursiveGetEpisode(episodes, i,numEpisodes,  UserInstance, web3, coinbase) {
		return UserInstance.getUserEpisode(i, {from:coinbase}).then((result)=>{
      console.log('here it is');
      console.log(web3.toAscii(result[0]));
      console.log(result);
      episodes = [...episodes, result ]

      /*
			const amount    = result[1].c[0],
						hexname   = result[2],
						retracted = result[3];

			if(!retracted) {
				// check if movie exists
				if(movies.find((movie)=>{ return movie.name === web3.toAscii(hexname) })){
					// adjust movie
					const objIndex = movies.findIndex((movie)=>{ return movie.name === web3.toAscii(hexname)})
					movies[objIndex].amount += amount/10000

				} else {
					// new movie
					movies = [...movies, {
						name   : web3.toAscii(hexname),
						amount : parseFloat(amount/10000)}
					]
				}
			}
      */

			// get the next movie if we're not finished, otherwise: return the movies
			if (i <= numEpisodes) {
				return episodes;
			} else {
				return this.recursiveGetEpisode(episodes, i+1, numEpisodes, UserInstance, web3, coinbase);
			}
		})
	}



}

export default UserHelper

