import java.util.ArrayList;
import java.util.Collection;


public class Category {

	private Collection <Movie> movies;
	private Double pricePerDay;
	private String CategoryName;
	
	public Category(){
		movies = new ArrayList<Movie>();
	}
	public String toString(){
		StringBuilder tmp = new StringBuilder();
		tmp.append("Category:"+CategoryName);
		for(Movie m: movies){
			tmp.append(m+",");
		}
		return tmp.toString();
	}
	
	public Integer getCountMovies(){
		return movies.size();
	}
	public Double getCostToRentAll(){
		return getCountMovies() * pricePerDay;
	}
	public void addMovie(Movie mov){
		movies.add(mov);
	}
	
	
	public Double getPricePerDay() {
		return pricePerDay;
	}
	public void setPricePerDay(Double pricePerDay) {
		this.pricePerDay = pricePerDay;
	}
	public Collection<Movie> getMovies(){
		return new ArrayList<Movie>(movies);
	}
	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}
	public String getCategoryName() {
		return CategoryName;
	}
}
