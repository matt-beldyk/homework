
package problem7;
import java.util.Map;


public class VideoStore {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		InventorySystem movies = new InventorySystem();
		
		movies.addMovie(new ArtMovie("Not in Techinicolor"));
		movies.addMovie(new ComedyMovie("Life Aquatic"));
		movies.addMovie(new ActionMovie("Mongol Rally"));
		movies.addMovie(new HorrorMovie("Ichi the Killer"));
		movies.addMovie(new RomanceMovie("Titanic"));
		movies.addMovie(new ComedyMovie("Bill and Ted"));
		movies.addMovie(new ComedyMovie("Super Troopers"));
		movies.addMovie(new HorrorMovie("Tokyo Gore Police"));
		
		System.out.println("** Movies **");
		for(Movie m: movies.getMovies()){
			System.out.println(m);
		}
		
		Map<String, Integer> cats = movies.getCategoryCounts();
		System.out.println("** Categories **");
		
		
		for(String k: cats.keySet()){
			System.out.println(k+"\t"+cats.get(k));
		}
		Double cost = 0.0;
		for(Movie m: movies.getMovies()){
			cost = cost + m.getPricePerDay()*2;
		}
		System.out.println("** Cost to Rent Everything for Two Days: $" + cost);


	}

}
