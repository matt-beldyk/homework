import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


public class InventorySystem {

	private Collection<Movie> movies;
	public InventorySystem(){
		movies = new ArrayList<Movie>();
	
	}
	public Collection<Movie> getMovies(){
		return new ArrayList<Movie>(movies);
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
	
	public void addMovie(Movie m){
		movies.add(m);
	}
	
	public Map<String, Integer> getCategoryCounts(){
		Map<String, Integer> cats = new HashMap<String, Integer>();
		for(Movie m: movies){
			if(!cats.containsKey(m.getCategory())){
				cats.put(m.getCategory(), 1);
			}else{
				cats.put(m.getCategory(), 1 + cats.get(m.getCategory()));
			}
		}
		return cats;
		
		
	}

}
