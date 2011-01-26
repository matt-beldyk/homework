import java.util.ArrayList;
import java.util.Collection;


public class InventorySystem {

	private Collection<Movie> movies;
	public InventorySystem(){
		movies = new ArrayList<Movie>();
	
	}
	public String toString(){
		StringBuilder tmp = new StringBuilder();
		tmp.append("InventorySystem:");
		for(Movie m: movies){
			tmp.append(m + ",");
		}
		return tmp.toString();
	}

	public String getMovieReport(){
		StringBuilder tmp = new StringBuilder();
		tmp.append("** Movie Report **\n");
		for(Movie m:movies){
			tmp.append(m+"\n");
		}
		return tmp.toString();
	}
	
	

}
